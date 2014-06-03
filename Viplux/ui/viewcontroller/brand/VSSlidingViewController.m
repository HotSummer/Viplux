//
//  VSSlidingViewController.m
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//


#import "VSSlidingViewController.h"
#import "VSBrandViewController.h"
#import "VSBrandToolBar.h"
#import "VSBrandManage.h"
#import "VSBrandMenu.h"

@interface VSSlidingViewController ()<UIScrollViewDelegate,VSBrandViewControllerDeleagte>{

    IBOutlet UIScrollView   *_scrollView;
    
    IBOutlet VSBrandToolBar *_toolBar;
    
    IBOutlet VSBrandMenu    *_menuList;
}

@property(nonatomic,assign)             NSUInteger selectedIndex;

@end

@implementation VSSlidingViewController

#pragma mark- contrller lifecircle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view lifecircle
- (void)loadView{
    _selectedIndex = 0;
    [super loadView];
    
    CGFloat scrollWidth = _scrollView.frame.size.width;
    CGFloat scrollHeight = _scrollView.frame.size.height;
    
    for (int i=0; i<[[[VSBrandDAO instance] getBrandList] count]; i++) {
        VSBrandViewController *controller = (VSBrandViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BrandViewController"];
        controller.m_delegate = self;
        controller.tag = i;
        controller.view.backgroundColor = [UIColor redColor];
        [self addChildViewController:controller];
        [controller.view setFrame:CGRectMake(i*scrollWidth, 0, scrollWidth, scrollHeight)];
    }
    
    [self setCurrentViewController];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*[self.childViewControllers count], _scrollView.frame.size.height);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setCurrentViewController{
    VSBrandViewController *vc = [self.childViewControllers objectAtIndex:_selectedIndex];
    if (!vc.view.superview) {
        [_scrollView addSubview:vc.view];
    }
    [VSBrandManage setCurrentViewController:vc];
    [_toolBar reload];
    [_menuList menuExpand:NO];
}

#pragma mark - delegages

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    VSBrandViewController *vc = [self.childViewControllers objectAtIndex:_selectedIndex];
    
    //reset UI for the last selectedViewController
    [vc reset];
   
    _selectedIndex =  scrollView.contentOffset.x/scrollView.frame.size.width;
    
    //set CurrentViewController
    [self setCurrentViewController];
    
    //remove viewController has been unload
    [self readyLoadView:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //Ready for viewController will load
    [self readyLoadView:YES];
}

- (void)readyLoadView:(BOOL)load{
    int leftIndex = _selectedIndex-1;
    int rightIndex = _selectedIndex+1;
    
    if (leftIndex>=0) {
        VSBrandViewController *leftVC = [self.childViewControllers objectAtIndex:leftIndex];
        if (load) {
            [_scrollView addSubview:leftVC.view];
        }else{
            [leftVC.view removeFromSuperview];
        }
    }
    if (rightIndex<self.childViewControllers.count) {
        VSBrandViewController *rightVC = [self.childViewControllers objectAtIndex:rightIndex];
        if (load) {
            [_scrollView addSubview:rightVC.view];
        }else{
            [rightVC.view removeFromSuperview];
        }
    }
}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{}

/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
       _selectedIndex =  scrollView.contentOffset.x/scrollView.frame.size.width;
    }
}
 */

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
}
*/

#pragma mark - public 
//  May be called by User
- (void)transitionToViewControllerAtIndex:(NSUInteger)index{
    
    if (index!=0&&index<self.childViewControllers.count) {
        [self readyLoadView:NO];
        _selectedIndex = index;
        [self setCurrentViewController];
        [self readyLoadView:YES];
        [_scrollView setContentOffset:CGPointMake(index*_scrollView.frame.size.width, 0) animated:NO];
    }else{
        NSLog(@"error: index out of range!");
    }
}


#pragma mark - VSBrandToolBarDelegate

-(void)showMenuList{
    [_menuList menuExpand];
}

#pragma mark - VSBrandViewControllerDeleagte
//  When brand will be draged to scrol, need hide toolbar and menu
-(void)hideToolBar{
    [_toolBar toolBarExpand:NO];
    [_menuList menuExpand:NO];
}

@end
