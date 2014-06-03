//
//  VSSegmentControl.h
//  Viplux
//
//  Created by xiang_ying on 14-1-7.
//  Copyright (c) 2014年 xiang_ying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSSegmentControl : UIImageView

@property(nonatomic,assign)NSUInteger    selectIndex;

//(nsstring)
- (void)setItems:(NSArray*)items;

-(void)setSelectButtonIndex:(NSInteger)index;

- (void)addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)event;

-(void)setTitleColor:(UIColor*)normal hight:(UIColor*)highlight;

@end
