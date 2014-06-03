//
//  NSObject+Addtions.m
//  Weimei
//
//  Created by Zhang Weifeng on 14-2-28.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "NSObject+Addtions.h"

@implementation NSObject (Addtions)
-(BOOL)stringCheck
{
   
    if (self&&[self isKindOfClass:[NSString class]]) {
        if ([(NSString*)self length]>0) {
            return YES;
        }
    }
    return NO;
}
@end
