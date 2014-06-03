//
//  VSSegmentControl.m
//  Viplux
//
//  Created by xiang_ying on 14-1-7.
//  Copyright (c) 2014年 xiang_ying. All rights reserved.
//

#import "VSSegmentControl.h"
#import "UIColor+TPCategory.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface VSSegmentControl(){
    CGFloat     offset;
    
    UIButton    *selectBtn;
    
    NSArray     *btnItems;
    
    SEL         selectorAction;
    
    id          delegate;
    
    UIImageView *selectBg;
    UIImage     *selectImg;
    
    UIImage     *separateLine;
    
    UIColor     *normalColor,*highlightColor;
}

@end

@implementation VSSegmentControl
@synthesize selectIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
    }
    return self;
}

//
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor redColor];
//        self.image = [[UIImage imageNamed:@"segment-bg"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
        selectImg = [[UIImage imageNamed:@"segment-press"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
        offset = 1;
        selectIndex = 0;
        separateLine = [UIImage imageNamed:@"segement-line"];
        [self setTitleColor:[UIColor lightGrayColor] hight:[UIColor darkGrayColor]];
    }
    return self;
}

-(void)setTitleColor:(UIColor*)normal hight:(UIColor*)highlight{
    normalColor = normal;
    highlightColor = highlight;
}

//(nsstring)
- (void)setItems:(NSArray*)items{

    btnItems = items;
    CGFloat width = (self.frame.size.width+offset-items.count)/items.count;
    for (int i = 0;i<items.count;i++) {
        NSString *item = items[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+100;
        btn.frame = CGRectMake(i*(width+offset), 0, width, self.frame.size.height);
        [btn setTitle:item forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.frame.size.height/2];
  
        [btn setTitleColor:highlightColor forState:UIControlStateSelected];
       
        if (i!=items.count-1) {
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*(width+offset), 0, 1, self.frame.size.height)];
            line.image = separateLine;
            [self addSubview:line];
        }

    }
    [self choose:(UIButton*)[self viewWithTag:100+selectIndex]];
}

-(void)setSelectButtonIndex:(NSInteger)index{
    
    selectBtn.selected = NO;
    [selectBtn setTitleColor:normalColor forState:UIControlStateNormal];
    selectBtn = (UIButton*)[self viewWithTag:100+index];
    [selectBtn setTitleColor:highlightColor forState:UIControlStateNormal];
    
    selectBtn.selected = YES;
    selectIndex = index;
    CGFloat width = (self.frame.size.width+offset-btnItems.count)/btnItems.count;
    if (!selectBg) {
        selectBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
        selectBg.image = selectImg;
        [self addSubview:selectBg];
        [self sendSubviewToBack:selectBg];
    }
    [UIView animateWithDuration:0.2 animations:^{
        selectBg.frame = CGRectMake(selectIndex*(width+offset), 0, width+offset, self.frame.size.height);
    }];
    
    if ([delegate respondsToSelector:selectorAction]) {
        SuppressPerformSelectorLeakWarning([delegate performSelector:selectorAction withObject:self]);
    }
}

-(void)choose:(UIButton*)sender{
    if (selectBtn == sender) {
        return;
    }
    [self setSelectButtonIndex:sender.tag-100];
}

- (void)addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)event{
    delegate = target;
    selectorAction = selector;
}


@end
