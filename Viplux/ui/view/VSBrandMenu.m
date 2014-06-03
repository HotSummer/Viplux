//
//  VSBrandMenu.m
//  Viplux
//
//  Created by xiangying on 14-5-30.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBrandMenu.h"

@interface VSBrandMenu()<UITableViewDataSource,UITableViewDelegate>{
    BOOL        expanded;
}

@end

@implementation VSBrandMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)menuExpand{
    [self menuExpand:!expanded];
}

- (void)menuExpand:(BOOL)expand{
    expanded = expand;
    [UIView animateWithDuration:0.3 animations:^{
        if (expand) {
            self.frame = CGRectMake(0, 49, self.frame.size.width, self.frame.size.height);
        }else{
            self.frame = CGRectMake(-self.frame.size.width, 49, self.frame.size.width, self.frame.size.height);
        }
    } completion:^(BOOL finished) {
        
    }];

}

- (void)reload{
    
}

- (void)reset{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - MenuData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"menucell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
