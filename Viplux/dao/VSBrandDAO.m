//
//  VSBrandDAO.m
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBrandDAO.h"

@interface VSBrandDAO()

@property(nonatomic,strong)NSMutableArray   *brandsArray;

@property(nonatomic,weak)VSBrandViewController *currentViewController;

@end

@implementation VSBrandDAO

+(instancetype)instance{
    static VSBrandDAO *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!dao) {
            dao = [[VSBrandDAO alloc] init];
        }
    });
    return dao;
}

-(instancetype)init{
    if (self = [super init]) {
        _brandsArray = [NSMutableArray array];
        
        VSBrandDTO *dto = [[VSBrandDTO alloc] init];
        dto.brand_name = @"GANT";
        [_brandsArray addObject:dto];
        
        dto = [[VSBrandDTO alloc] init];
        dto.brand_name = @"Stella Luna";
        [_brandsArray addObject:dto];
        
        dto = [[VSBrandDTO alloc] init];
        dto.brand_name = @"ASH";
        [_brandsArray addObject:dto];
        
        dto = [[VSBrandDTO alloc] init];
        dto.brand_name = @"Tod's";
        [_brandsArray addObject:dto];
        
        dto = [[VSBrandDTO alloc] init];
        dto.brand_name = @"Ports";
        [_brandsArray addObject:dto];
        
        dto = [[VSBrandDTO alloc] init];
        dto.brand_name = @"Nine West";
        [_brandsArray addObject:dto];
    }
    return self;
}

//  Set current brand viewController
-(void)setCurrentViewController:(VSBrandViewController*)viewController{
    _currentViewController = viewController;
}


//  Get current brand viewController
- (VSBrandViewController*)getCurrentViewController{
    return _currentViewController;
}


#pragma mark - VSBrandToolBar Methodes
//  This part is methods for VSBrandToolBar
//  Goto brandListView
- (void)go2BrandList{
    [_currentViewController.navigationController popViewControllerAnimated:YES];
}

//  ShowBrandMenu
- (void)showBrandMenu{
    if ([_currentViewController.parentViewController respondsToSelector:@selector(showMenuList)]) {
        [_currentViewController.parentViewController performSelector:@selector(showMenuList)];
    }
}

//  Goto ShoppingBag
- (void)go2ShoopingBag{
    
}

//  Goto Personal
- (void)go2Personal{
    
}


#pragma mark -
//
-(NSArray*)getBrandList{
    
    return _brandsArray;
}

//  Get current brand
- (VSBrandDTO*)getBrand{
    return _brandsArray[_currentViewController.tag];
}

@end
