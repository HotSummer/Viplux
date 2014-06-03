//
//  VSSystemHelper.m
//  AFNetWorkPro
//
//  Created by summer.zhu on 30/5/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import "VSSystemHelper.h"
#import "NSString_Extras.h"

@implementation VSSystemHelper

+(NSString *)getUDID{
    NSString *uuid =[[NSUUID UUID] UUIDString];
    return uuid;
}

+(NSString *)getUserToken
{
    return @"";
}

+(NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+(NSString*)getApiKey
{
    return @"007b4af4727d99f1539bf2980f9aa922";
}

+(NSString*)getApiSecret
{
    return @"cbffa4c30926b8f87a296f693588c433";
}

+(NSString*)getServer
{
    return @"http://mapi.vip.com/vips-mobile/router.do";//@"http://192.168.42.92:8080/vips-mobile/router.do";
}

+(NSString*)getApiSignWithData:(NSDictionary*)param
{
    //apikey与所以其他参数通过接口参数key的字母排序，将value整理。再做md5. 本方法中param中已经包含apikey
    
    //将key以字母排序
    NSArray *values = [param allKeys];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedArray = [values sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    
    //以key的字母顺序整理value
    NSMutableArray *valueArr = [[NSMutableArray alloc] init];
    for (int i =0; i<sortedArray.count; i++) {
        NSString *key = [sortedArray objectAtIndex:i];
        [valueArr insertObject:[param objectForKey:key] atIndex:i];
    }
    NSString *valueSting = nil;
    if(valueArr.count){
        valueSting = [valueArr componentsJoinedByString:@""];
    }
    //追加api secret
    NSString *strAddSecret = [valueSting stringByAppendingString:[VSSystemHelper getApiSecret]];
    
    //ascii码array,iOS不需要
    //    NSMutableArray *charArray = [[NSMutableArray alloc] init];
    //    for (int j =0; j<strAddSecret.length; j++) {
    //        unichar ucharr = [strAddSecret characterAtIndex:j];
    //        NSString *charr = [NSString stringWithFormat:@"%d",(int)ucharr];
    //        if(charr)
    //            [charArray insertObject:charr atIndex:j];
    //    }
    //
    //    NSString *signArr = [charArray componentsJoinedByString:@""];
    //md5
    NSString *apiSign = [strAddSecret MD5Hash];
    return apiSign;
}

@end
