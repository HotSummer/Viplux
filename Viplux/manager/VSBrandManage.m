//
//  VSBrandManage.m
//  Viplux
//
//  Created by xiangying on 14-5-30.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBrandManage.h"

@implementation VSBrandManage

//  Set current brand viewController
+(void)setCurrentViewController:(VSBrandViewController*)viewController{
    [[VSBrandDAO instance] setCurrentViewController:viewController];
}


//  Get current brand viewController
+ (VSBrandViewController*)getCurrentViewController{
    return [[VSBrandDAO instance] getCurrentViewController];
}


#pragma mark - VSBrandToolBar Methodes
//  This part is methods for VSBrandToolBar
//  Goto brandListView
+ (void)go2BrandList{
    [[VSBrandDAO instance] go2BrandList];
}

//  ShowBrandMenu
+ (void)showBrandMenu{
    [[VSBrandDAO instance] showBrandMenu];
}

//  Goto ShoppingBag
+ (void)go2ShoopingBag{
    [[VSBrandDAO instance] go2ShoopingBag];
}

//  Goto Personal
+ (void)go2Personal{
    [[VSBrandDAO instance] go2Personal];
}


#pragma mark -

// Get BrandList
+ (NSArray*)getBrandList{
    return [[VSBrandDAO instance] getBrandList];
}

//  Get current brand
+ (VSBrandDTO*)getBrand{
    return [[VSBrandDAO instance] getBrand];
}

@end
