//
//  Reflection.h
//  AFNetWorkPro
//
//  Created by summer.zhu on 30/5/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reflection : NSObject

+ (id)shareInstance;

/**********************************************************
 函数名称：contenToClass
 函数描述：根据JSON串实例化成对象并赋值
 输入参数：(NSString *)classname：对象名。
 返回值：id：实例化后的对象。
 **********************************************************/
- (id)contentToClass:(id)content className:(NSString *)className;

/**********************************************************
 函数名称：ClassToContent
 函数描述：反射请求
 输入参数：(id)obj：请求实体类。
 输出参数：无
 返回值：NSDictionary：根据属性封装成对应的Dictionary。
 **********************************************************/
-(NSMutableDictionary*)ClassToContent:(id)obj;

@end
