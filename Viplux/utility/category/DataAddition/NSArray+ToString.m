//
//  NSArray+ToString.m
//  Weimei
//
//  Created by Zhang Weifeng on 14-3-7.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "NSArray+ToString.h"

@implementation NSArray (ToString)
-(NSString*)toString
{
    if (self==nil)return nil;
    NSMutableString *String = [[NSMutableString alloc] initWithString:@"("];
    for (int i=0; i<[self count]; i++) {
        if (i==0){
            [String appendString:[self objectAtIndex:i]];
        }else{
            [String appendString:@","];
            [String appendString:[self objectAtIndex:i]];
        }
    }
    [String appendString:@")"];
    
    return String;
}
@end
