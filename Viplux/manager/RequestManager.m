//
//  RequestManager.m
//  AFNetWorkPro
//
//  Created by summer.zhu on 30/5/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import "RequestManager.h"
#import "VSSystemHelper.h"
#import "Reflection.h"
#import "AFHTTPRequestOperationManager.h"

@implementation RequestManager

+ (id)shareInstance{
    static RequestManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[RequestManager alloc] init];
    });
    return manager;
}

- (void)sendRequest:(RequestSuperEntity *)requestEntity andDelegate:(id<RequestDelegate>)delegate{
    NSDictionary *dic = [[Reflection shareInstance] ClassToContent:requestEntity];
    [[RequestManager shareInstance] sendRequestWitServiceName:requestEntity.serviceName andMethodName:requestEntity.methodName andResponseClassName:requestEntity.responseClassName andParams:dic andDelegate:delegate];
}

-(void) sendRequestWitServiceName:(NSString *)serviceName
                    andMethodName:(NSString *)method
             andResponseClassName:(NSString *)responseClassName
                        andParams:(NSDictionary *)params
                      andDelegate:(id<RequestDelegate>)delegate{
    NSString *udid = [VSSystemHelper getUDID];
    NSString *userToken = [VSSystemHelper getUserToken];
    
    //整理固定请求参数
    NSMutableDictionary *finalParam = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    [finalParam setObject:@"weimei_iphone" forKey:@"app_name"];
    [finalParam setObject:[VSSystemHelper getAppVersion] forKey:@"app_version"];
    [finalParam setObject:udid forKey:@"mars_cid"];
    [finalParam setObject:@"" forKey:@"user_id"];
    [finalParam setObject:@"iphone" forKey:@"client_type"];
    [finalParam setObject:serviceName forKey:@"service"];//service name
    [finalParam setObject:udid forKey:@"mid"];
    [finalParam setObject:userToken forKey:@"user_token"];
    
    //apikey与所以其他参数通过接口参数key的字母排序，将value整理。再做md5.
    NSString *apiKey = [VSSystemHelper getApiKey];
    //添加apikey
    [finalParam setObject:apiKey forKey:@"api_key"];
    NSString *apiSign = [VSSystemHelper getApiSignWithData:finalParam];
    //请求的request中再次传入apikey和apisign
    [finalParam setObject:apiKey forKey:@"api_key"];
    [finalParam setObject:apiSign forKey:@"api_sign"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    if([method isEqualToString:@"POST"])
    {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //POST方式请求
        [manager POST:[VSSystemHelper getServer] parameters:finalParam success:^(AFHTTPRequestOperation *operation, id responseObject){
            if ([delegate respondsToSelector:@selector(requestSuccessWith:response:resultData:serviceName:)]) {
                id responseObj = [[Reflection shareInstance] contentToClass:responseObject className:responseClassName];
                [delegate requestSuccessWith:operation.request response:operation.response resultData:responseObj serviceName:serviceName];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            if ([delegate respondsToSelector:@selector(requestFailWith:response:error:resultData:serviceName:)]) {
                [delegate requestFailWith:operation.request response:operation.response error:error resultData:nil serviceName:serviceName];
            }
        }];
    }
    else{
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //GET方式为默认
        [manager GET:[VSSystemHelper getServer] parameters:finalParam success:^(AFHTTPRequestOperation *operation, id responseObject){
            if ([delegate respondsToSelector:@selector(requestSuccessWith:response:resultData:serviceName:)]) {
                id responseObj = [[Reflection shareInstance] contentToClass:responseObject className:responseClassName];
                [delegate requestSuccessWith:operation.request response:operation.response resultData:responseObj serviceName:serviceName];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            if ([delegate respondsToSelector:@selector(requestFailWith:response:error:resultData:serviceName:)]) {
                [delegate requestFailWith:operation.request response:operation.response error:error resultData:nil serviceName:serviceName];
            }
        }];
    }
}


@end
