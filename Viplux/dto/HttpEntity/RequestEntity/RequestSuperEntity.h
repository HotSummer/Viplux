//
//  RequestSuperEntity.h
//  AFNetWorkPro
//
//  Created by summer.zhu on 3/6/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestSuperEntity : NSObject

@property(nonatomic, strong) NSString *serviceName;
@property(nonatomic, strong) NSString *methodName;
@property(nonatomic, strong) NSString *responseClassName;

@end
