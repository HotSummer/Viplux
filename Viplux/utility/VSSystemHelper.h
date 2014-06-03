//
//  VSSystemHelper.h
//  AFNetWorkPro
//
//  Created by summer.zhu on 30/5/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSSystemHelper : NSObject

+(NSString *)getUDID;
+(NSString *)getUserToken;
+(NSString *)getAppVersion;
+(NSString *)getApiKey;
+(NSString *)getApiSecret;
+(NSString *)getServer;
+(NSString *)getApiSignWithData:(NSDictionary*)param;

@end
