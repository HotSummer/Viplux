//
//  VSShoppingCenterViewController.m
//  Viplux
//
//  Created by xiangying on 14-5-30.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSShoppingCenterViewController.h"
#import "VSSegmentControl.h"
#import "VSShoppingCell.h"

@interface VSShoppingCenterViewController ()<VSSwipeableCellDataSource,VSSwipeableCellDelegate,UIScrollViewDelegate>{
    IBOutlet    VSSegmentControl    *_segment;
    
    IBOutlet    UIScrollView        *_contentView;
    IBOutlet    UITableView         *_tableView;
}

@end

@implementation VSShoppingCenterViewController

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
//    [_tableView registerClass:[VSShoppingCell class] forCellReuseIdentifier:@"cell"];

    [_segment setItems:@[@"在线购买",@"到店试穿"]];

    [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_contentView setContentSize:CGSizeMake(_contentView.frame.size.width*2, _contentView.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)segmentChange:(VSSegmentControl*)sender{
//    NSLog(@"segment choose index: %d",[sender selectIndex]);
    [_contentView setContentOffset:CGPointMake(sender.selectIndex*1024, 0) animated:YES];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VSShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopbuycell" forIndexPath:indexPath];
//    cell.indexPath = indexPath;
//    cell.dataSource = self;
//    cell.delegate = self;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - DNSSwipeableCellDataSource

#pragma mark Required Methods
- (NSInteger)numberOfButtonsInSwipeableCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}

- (NSString *)titleForButtonAtIndex:(NSInteger)index inCellAtIndexPath:(NSIndexPath *)indexPath
{
    switch (index) {
        case 0:
            return @"颜色";
            break;
        case 1:
            return @"尺码";
            break;
        case 2:
            return @"件数";
            break;
        default:
            break;
    }
    
    return nil;
}

- (UIColor *)backgroundColorForButtonAtIndex:(NSInteger)index inCellAtIndexPath:(NSIndexPath *)indexPath
{
    switch (index) {
        case 0:
            return [UIColor redColor];
            break;
        default: {
            return [UIColor greenColor];
        }
            break;
    }
}

- (UIColor *)textColorForButtonAtIndex:(NSInteger)index inCellAtIndexPath:(NSIndexPath *)indexPath
{
    switch (index) {
        case 0:
            return [UIColor whiteColor];
            break;
        default: {
            //Note that the random index means colors won't persist after recycling.
            return [UIColor blackColor];
        }
            break;
    }
}

- (void)swipeableCell:(VSShoppingCell *)cell didSelectButtonAtIndex:(NSInteger)index{
    
}

/**
 * Notifies the delegate that a particular cell did open, to facilitate the delegate's
 * management of which cells are open and which cells are closed.
 * @param cell - The swipeable cell which opened.
 */
- (void)swipeableCellDidOpen:(VSShoppingCell *)cell{
    
}

/**
 * Notifies the delegate that a particular cell did close, to facilitate the delegate's
 * management of which cells are open and which cells are closed.
 * @param cell - The swipeable cell which closed.
 */
- (void)swipeableCellDidClose:(VSShoppingCell *)cell{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _contentView) {
        [_segment setSelectButtonIndex:scrollView.contentOffset.x/1024];
    }
}
@end
