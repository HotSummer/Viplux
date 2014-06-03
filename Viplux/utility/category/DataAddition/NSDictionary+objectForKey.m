//
//  NSDictionary+objectForKey.m
//  Weimei
//
//  Created by Zhang Weifeng on 14-3-17.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "NSDictionary+objectForKey.h"

@implementation NSDictionary (objectForKey)

-(id)objectForKey:(NSString*)key placeHoler:(id)placeHoler
{
    if ([self objectForKey:key]) {
        return [self objectForKey:key];
    }else{
        return placeHoler;
    }
}

@end
