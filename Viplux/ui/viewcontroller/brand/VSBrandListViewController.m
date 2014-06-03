//
//  VSBrandListViewController.m
//  Viplux
//
//  Created by xiangying on 14-5-29.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBrandListViewController.h"

@interface VSBrandListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation VSBrandListViewController

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
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SlidingViewController"];
    [self.navigationController pushViewController:controller animated:NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jump2brandDetail:(id)sender{
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"brandCell" forIndexPath:indexPath];
    
    return cell;
}
@end
