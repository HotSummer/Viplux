//
//  VSBrandViewController.m
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBrandViewController.h"

@interface VSBrandViewController ()<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet    UITableView *_brandView;
}

@end

@implementation VSBrandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)reset{
    [_brandView setContentOffset:CGPointZero];
}

- (void)reload{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Product" forIndexPath:indexPath];
    }else if(indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Video" forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Message" forIndexPath:indexPath];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.m_delegate respondsToSelector:@selector(hideToolBar)]) {
        [self.m_delegate hideToolBar];
    }
}

@end
