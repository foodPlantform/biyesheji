//
//  pinglunView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "pinglunView.h"

@implementation pinglunView
-(instancetype)init
{
    if (self == [super init]) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self addSubview:_scrollView];
    self.starLabel =  [[UILabel alloc]initWithFrame:CGRectMake(10, 40, kScreenWidth, 50)];
    self.starLabel.text = @"用户星级:";
    [self.scrollView addSubview:_starLabel];
    self.star = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.starLabel.frame)+10, 100, 50)];
    self.star.allowsHalfStars = YES;
    self.star.maximumValue = 5;
    self.star.minimumValue = 1;
    self.star.tintColor = [UIColor redColor];
    [self.scrollView addSubview:_star];
    self.pinglunLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.star.frame), CGRectGetMaxY(self.star.frame)+20, kScreenWidth, 50)];
    self.pinglunLabel.text = @"评论内容:";
    [self.scrollView addSubview:_pinglunLabel];
    self.pinglun = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.pinglunLabel.frame)+10, kScreenWidth - 20, 60)];
    self.pinglun.borderStyle = UITextBorderStyleRoundedRect;

    
    [self.scrollView addSubview:_pinglun];
    self.sure = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sure.frame = CGRectMake(kScreenWidth/2 - 50, CGRectGetMaxY(self.pinglun.frame)+10, 100, 50);
    [self.sure setTitle:@"提交" forState:UIControlStateNormal];
    [self.scrollView addSubview:_sure];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
