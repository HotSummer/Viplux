//
//  VSBaseViewController.m
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBaseViewController.h"

@interface VSBaseViewController ()

@end

@implementation VSBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
