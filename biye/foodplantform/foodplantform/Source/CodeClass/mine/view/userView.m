//
//  userView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "userView.h"

@implementation userView
-(instancetype)init
{
    if (self = [super init]) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self addSubview:_scrollView];
    self.headimg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3, 20, kScreenWidth/3, kScreenWidth/3)];
    self.headimg.layer.cornerRadius = 50;
    self.headimg.layer.masksToBounds = YES;
    [self.scrollView addSubview:_headimg];
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headimg.frame)+10, 70, 50)];
    self.userNameLabel.text = @"用户名";
    [self.scrollView addSubview:_userNameLabel];
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame), CGRectGetMinY(self.userNameLabel.frame), kScreenWidth - 100, CGRectGetHeight(self.userNameLabel.frame))];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_userName];
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.userNameLabel.frame)+10, CGRectGetWidth(self.userNameLabel.frame), CGRectGetHeight(self.userNameLabel.frame))];
    self.phoneLabel.text = @"电话号";
    [self.scrollView addSubview:_phoneLabel];
    self.phone = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneLabel.frame), CGRectGetMinY(self.phoneLabel.frame), CGRectGetWidth(self.userName.frame), CGRectGetHeight(self.userName.frame))];
    self.phone.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_phone];
    self.genderLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneLabel.frame), CGRectGetMaxY(self.phoneLabel.frame)+10, CGRectGetWidth(self.phoneLabel.frame), CGRectGetHeight(self.phoneLabel.frame))];
    self.genderLabel.text = @"性别";
    [self.scrollView addSubview:_genderLabel];
    self.gender = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.genderLabel.frame), CGRectGetMinY(self.genderLabel.frame), CGRectGetWidth(self.phone.frame), CGRectGetHeight(self.phone.frame))];
    self.gender.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_gender];
//    self.sure = [UIButton buttonWithType: UIButtonTypeSystem];
//    self.sure.frame = CGRectMake(kScreenWidth/3, CGRectGetMaxY(self.gender.frame)+10, kScreenWidth/3, 50);
//    [self.sure setTitle:@"确定" forState:UIControlStateNormal];
//    [self.scrollView addSubview:_sure];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.gender.frame)+30);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
