//
//  userMessageView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "userMessageView.h"

@implementation userMessageView
-(instancetype)init
{
    if (self = [super init]) {
    
        [self setView];
    }
    return self;
}
-(void)setView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-170)];
    [self addSubview:_scrollView];
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 100, 50)];
    self.userNameLabel.text = @"用户名:";
    [self.scrollView addSubview:_userNameLabel];
    self.userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame), CGRectGetMinY(self.userNameLabel.frame), kScreenWidth -CGRectGetWidth(self.userNameLabel.frame)-5, CGRectGetHeight(self.userNameLabel.frame))];
    [self.scrollView addSubview:_userName];
    self.phoneLabel =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.userNameLabel.frame)+5, 100, 50)];
    self.phoneLabel.text = @"联系方式:";
    [self.scrollView addSubview:_phoneLabel];
    self.phone = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneLabel.frame), CGRectGetMinY(self.phoneLabel.frame), kScreenWidth - CGRectGetWidth(self.phoneLabel.frame)-5, CGRectGetHeight(self.phoneLabel.frame))];
    [self.scrollView addSubview:_phone];
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneLabel.frame), CGRectGetMaxY(self.phoneLabel.frame)+5, 100, 50)];
    self.addressLabel.text = @"联系地址:";
    [self.scrollView addSubview:_addressLabel];
    self.address = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressLabel.frame), CGRectGetMinY(self.addressLabel.frame), kScreenWidth - CGRectGetWidth(self.addressLabel.frame)-5, CGRectGetHeight(self.addressLabel.frame))];
    [self.scrollView addSubview:_address];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
