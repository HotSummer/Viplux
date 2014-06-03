//
//  VSBrandViewController.h
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSBrandViewControllerDeleagte <NSObject>

//  When brand will be draged to scrol, need hide toolbar
-(void)hideToolBar;

@end

@interface VSBrandViewController : VSBaseViewController

@property(nonatomic,weak)id<VSBrandViewControllerDeleagte> m_delegate;
@property(nonatomic,assign)NSUInteger tag;

//  When self resign currentViewController, need reset UI or Data
//  mostly called by  parentViewController's currentViewController
//  is not self anymore
- (void)reset;

//  When CurrentViewController is self , need reload UI or Data
- (void)reload;



@end
