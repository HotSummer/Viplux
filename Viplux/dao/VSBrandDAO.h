//
//  VSBrandDAO.h
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

//  Dataprocessingcenter for brand，Datacell is VSBrandDTO

#import <Foundation/Foundation.h>
#import "VSBrandViewController.h"
#import "VSBrandDTO.h"

@interface VSBrandDAO : NSObject

+(instancetype)instance;

//  Set current brand viewController
- (void)setCurrentViewController:(VSBrandViewController*)viewController;

//  Get current brand viewController
- (VSBrandViewController*)getCurrentViewController;

#pragma mark - VSBrandToolBar Methodes
//  This part is methods for VSBrandToolBar
//  Goto brandListView
- (void)go2BrandList;

//  ShowBrandMenu
- (void)showBrandMenu;

//  Goto ShoppingBag
- (void)go2ShoopingBag;

//  Goto Personal
- (void)go2Personal;

// Get BrandList
- (NSArray*)getBrandList;

//  Get current brand
- (VSBrandDTO*)getBrand;

@end
