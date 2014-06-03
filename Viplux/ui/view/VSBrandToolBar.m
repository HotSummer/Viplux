//
//  VSBrandToolBar.m
//  Viplux
//
//  Created by xiangying on 14-5-30.
//  Copyright (c) 2014年 Vip. All rights reserved.
//

#import "VSBrandToolBar.h"
#import "VSBrandManage.h"
#import "NSString+TPCategory.h"

@interface VSBrandToolBar(){
    
    IBOutlet    UILabel     *_title;
    
    IBOutlet    UIButton    *_listBtn;
    IBOutlet    UIButton    *_menuBtn;
    IBOutlet    UIButton    *_shoppingBagBtn;
    IBOutlet    UIButton    *_personalBtn;
    
    BOOL        expanded;
    
    UITapGestureRecognizer  *_tapGeusture;
}

@end

@implementation VSBrandToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    expanded = YES;
    _tapGeusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolBar)];
    [self addGestureRecognizer:_tapGeusture];
    [_tapGeusture setEnabled:NO];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)reload{
    VSBrandDTO *brand = [VSBrandManage getBrand];
    _title.text = brand.brand_name;
    if (!expanded) {
        //unexpand the toolBar
        CGFloat width = [_title.text widthwithfont:_title.font height:_title.frame.size.height]+20;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self setFrame:CGRectMake(1024-width-20, 0, width, 49)];
            _title.frame = self.bounds;
        } completion:^(BOOL finished) {
            _title.frame = self.bounds;
            _listBtn.hidden = _menuBtn.hidden = _shoppingBagBtn.hidden = _personalBtn.hidden = YES;
        }];
    }
}

- (void)showToolBar{
    [self toolBarExpand:YES];
}

-(void)toolBarExpand:(BOOL)expand{
    if (expand) {
        //expand the toolBar
        [UIView animateWithDuration:0.5 animations:^{
            [self setFrame:CGRectMake(0, 0, 1024, 49)];
            _title.frame = self.bounds;
            _listBtn.hidden = _menuBtn.hidden = _shoppingBagBtn.hidden = _personalBtn.hidden = NO;
        } completion:^(BOOL finished) {
            expanded = expand;
            _tapGeusture.enabled = !expand;
        }];
    }else{
        //unexpand the toolBar
        CGFloat width = [_title.text widthwithfont:_title.font height:_title.frame.size.height]+20;
        [UIView animateWithDuration:0.5 animations:^{
            _listBtn.hidden = _menuBtn.hidden = _shoppingBagBtn.hidden = _personalBtn.hidden = YES;
            [self setFrame:CGRectMake(1024-width-20, 0, width, 49)];
            _title.frame = self.bounds;
        } completion:^(BOOL finished) {
            _title.frame = self.bounds;
            expanded = expand;
            _tapGeusture.enabled = !expand;
        }];
    }
}

#pragma mark - Button Methodes

-(IBAction)go2BrandList:(id)sender{
    [VSBrandManage go2BrandList];
}

-(IBAction)showMenuList:(id)sender{
    [VSBrandManage showBrandMenu];
}

-(IBAction)go2ShoopingBag:(id)sender{
    [VSBrandManage go2ShoopingBag];
}

-(IBAction)go2Personal:(id)sender{
    [VSBrandManage go2Personal];
}

@end
