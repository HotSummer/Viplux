//
//  RequestManager.h
//  AFNetWorkPro
//
//  Created by summer.zhu on 30/5/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestSuperEntity.h"

@protocol RequestDelegate <NSObject>

@optional
-(void)requestSuccessWith:(NSURLRequest*)request
				 response:(NSHTTPURLResponse*)response
			   resultData:(id)obj
			  serviceName:(NSString*)serviceName;

-(void)requestFailWith:(NSURLRequest*)request
			  response:(NSHTTPURLResponse*)response
				 error:(NSError*)err
			resultData:(id)obj
		   serviceName:(NSString*)serviceName;

@end

@interface RequestManager : NSObject

+ (id)shareInstance;

- (void)sendRequest:(RequestSuperEntity *)requestEntity andDelegate:(id<RequestDelegate>)delegate;

- (void) sendRequestWitServiceName:(NSString *)serviceName
                    andMethodName:(NSString *)method
             andResponseClassName:(NSString *)responseClassName
                        andParams:(NSDictionary *)params
                      andDelegate:(id<RequestDelegate>)delegate;

@end
