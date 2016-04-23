//
//  regView.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "regView.h"

@implementation regView
-(instancetype)init
{
    if (self = [super init] ) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView
{
    self.backgroundColor = [UIColor whiteColor];
    // 用户名
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 50)];
    self.userName.placeholder = @"用户名";
    self.userName.layer.borderWidth = 0.5;
    self.userName.layer.borderColor = [UIColor grayColor].CGColor;
    self.userName.textAlignment = UITextAlignmentCenter;
    [self addSubview:_userName];
    
    // 密码
    self.pwStr  = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userName.frame)+20, kScreenWidth, 50)];
    self.pwStr.placeholder = @"密码";
    self.pwStr.layer.borderWidth = 0.5;
    self.pwStr.layer.borderColor = [UIColor grayColor].CGColor;
    self.pwStr.textAlignment = UITextAlignmentCenter;
    [self addSubview:_pwStr];
    
    // 确认密码
    self.ensurePwStr = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pwStr.frame)+20, kScreenWidth, 50)];
    self.ensurePwStr.placeholder = @"确认密码";
    self.ensurePwStr.layer.borderWidth = 0.5;
    self.ensurePwStr.layer.borderColor = [UIColor grayColor].CGColor;
    self.ensurePwStr.textAlignment = UITextAlignmentCenter;
    [self addSubview:_ensurePwStr];
    
    // 注册按钮
    
    self.regBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    self.regBtn.frame = CGRectMake(0, CGRectGetMaxY(self.ensurePwStr.frame)+20, kScreenWidth, 50);
    self.regBtn.backgroundColor = [UIColor blueColor];
    
    [self.regBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.regBtn.tintColor = [UIColor whiteColor];
    [self addSubview:_regBtn];
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
