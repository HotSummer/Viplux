//
//  VSSlidingViewController.h
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//


//  BrandViewController Container
//  self childViewControllers is VSBrandViewController
#import <UIKit/UIKit.h>

@interface VSSlidingViewController : VSBaseViewController

//  May be called by User
- (void)transitionToViewControllerAtIndex:(NSUInteger)index;

@end
