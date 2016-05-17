//
//  chooseTimeView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "chooseTimeView.h"

@implementation chooseTimeView

-(instancetype)init
{
    if (self == [super init]) {
        [self p_setView];
    }
    return self;
}

-(void)p_setView
{
    self.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self addSubview:_scrollView];
    self.time = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 100, 30, 200, 50)];
    self.time.placeholder = @"点击选择时间";
    self.time.borderStyle = UITextBorderStyleRoundedRect;
    self.time.textAlignment = UITextAlignmentCenter;
    [self.scrollView addSubview:_time];
    self.sure = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sure.frame = CGRectMake(CGRectGetMinX(self.time.frame), CGRectGetMaxY(self.time.frame)+10, CGRectGetWidth(self.time.frame), 50);
    self.sure.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.sure.layer.borderWidth = 1;
    self.sure.tintColor = [UIColor darkGrayColor];
    [self.sure setTitle:@"确定" forState:UIControlStateNormal];
    [self.scrollView addSubview:_sure];
}
/*
//
 Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
