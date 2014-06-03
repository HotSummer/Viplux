//
//  NSDictionary+objectForKey.h
//  Weimei
//
//  Created by Zhang Weifeng on 14-3-17.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (objectForKey)
-(id)objectForKey:(NSString*)key placeHoler:(id)placeHoler;
@end
