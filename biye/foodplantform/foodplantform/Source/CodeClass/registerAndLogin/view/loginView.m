//
//  loginView.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "loginView.h"

@implementation loginView

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
    [self.pwStr setSecureTextEntry:YES];
    [self addSubview:_pwStr];
    
    
    // 登陆按钮
    
    self.loginBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.pwStr.frame)+20, kScreenWidth, 50);
    self.loginBtn.backgroundColor = [UIColor blueColor];
    
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    self.loginBtn.tintColor = [UIColor whiteColor];
    [self addSubview:_loginBtn];
    
    
    // 注册按钮
    self.regBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.regBtn.frame = CGRectMake(0, CGRectGetMaxY(self.loginBtn.frame)+20, kScreenWidth, 50);
    self.regBtn.backgroundColor = [UIColor redColor];
    [self.regBtn setTitle:@"去注册" forState:UIControlStateNormal];
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
