//
//  Reflection.m
//  AFNetWorkPro
//
//  Created by summer.zhu on 30/5/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import "Reflection.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Reflection

+ (id)shareInstance{
    static Reflection *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[Reflection alloc] init];
    });
    return instance;
}

static const char* getPropertyType(objc_property_t property) {
    
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
    
}

- (id)contentToClass:(id)content className:(NSString *)className{
    Class class = NSClassFromString(className);
    NSObject *object = [[class alloc] init];
    unsigned int propertyCount;
    objc_property_t *pProperty = class_copyPropertyList(class, &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property = pProperty[i];
        const char *propertyName = property_getName(property);
        const char *propertyType = getPropertyType(property);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];
        
        if ([type isEqualToString:@"NSArray"] || [type isEqualToString:@"NSMutableArray"]) {
            if ([content isKindOfClass:[NSDictionary class]]) {
                NSArray *datas = [content objectForKey:key];
                if (datas.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:datas.count];
                    for (NSDictionary *dic in datas) {
                        NSObject *obj = [[Reflection shareInstance] contentToClass:dic className:key];
                        [arr addObject:obj];
                    }
                    [object setValue:arr forKey:key];
                }
            }else if([content isKindOfClass:[NSArray class]]){
                NSArray *arrContent = content;
                if (arrContent.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
                    for (NSDictionary *dic in arrContent) {
                        NSObject *obj = [[Reflection shareInstance] contentToClass:dic className:key];
                        [arr addObject:obj];
                    }
                    [object setValue:arr forKey:key];
                }
            }
        }else{//content肯定不会是一个array
            id obj = [content objectForKey:key];
            if (!obj)
                continue;
            if ([type isEqualToString:@"i"] || [type isEqualToString:@"l"] || [type isEqualToString:@"s"]) {
                [object setValue:[NSNumber numberWithInteger:[obj integerValue]] forKey:key];
            }else if ([type isEqualToString:@"I"] || [type isEqualToString:@"L"] || [type isEqualToString:@"S"]) {
                [object setValue:[NSNumber numberWithLongLong:[obj longLongValue]] forKey:key];
            }else if ([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
                [object setValue:[NSNumber numberWithDouble:[obj doubleValue]] forKey:key];
            }else if ([type isEqualToString:@"c"]) {
                [object setValue:[NSNumber numberWithChar:[obj charValue]] forKey:key];
            }else if([type isEqualToString:@"NSNumber"]){
                [object setValue:obj forKey:key];
            }else if ([type isEqualToString:@"NSString"]) {
                NSString *value = (NSString *)obj;
                if (value.length > 0) {
                    [object setValue:value forKey:key];
                }
            }
        }
    }
    if (pProperty) {
        free(pProperty);
    }
    return object;
}


-(NSMutableDictionary*)ClassToContent:(id)obj
{
    NSString *className = NSStringFromClass([obj class]);
    
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *name = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *type = [[NSString alloc] initWithCString:getPropertyType(property) encoding:NSUTF8StringEncoding];
        SEL selector = NSSelectorFromString(name);
        if ([obj respondsToSelector:selector]) {
            id value = [obj performSelector:selector];
            if ([type isEqualToString:@"i"] || [type isEqualToString:@"l"] || [type isEqualToString:@"s"]) {
                [finalDict setObject:[NSNumber numberWithInteger:[value integerValue]] forKey:name];
            } else if ([type isEqualToString:@"I"] || [type isEqualToString:@"L"] || [type isEqualToString:@"S"]) {
                [finalDict setObject:[NSNumber numberWithLongLong:[value longLongValue]] forKey:name];
            } else if ([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
                [finalDict setObject:[NSNumber numberWithDouble:[value doubleValue]] forKey:name];
            } else if ([type isEqualToString:@"NSString"]) {
                if (value!=nil) {
                    [finalDict setObject:[NSString stringWithFormat:@"%@", value] forKey:name];
                }
            } else if ([type isEqualToString:@"c"]) {
                [finalDict setObject:[NSNumber numberWithChar:[value charValue]] forKey:name];
            } else if ([type isEqualToString:@"NSNumber"]){
                [finalDict setObject:value forKey:name];
            }
            else if ([type isEqualToString:@"NSMutableArray"]) {
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:value];
                NSMutableArray *results = [[NSMutableArray alloc] init];
                for (id onceId in array) {
                    [results addObject:[self ClassToContent:onceId]];
                }
                [finalDict setObject:results forKey:name];
            }
        }
    }
    free(properties);
    return finalDict;
}

@end
