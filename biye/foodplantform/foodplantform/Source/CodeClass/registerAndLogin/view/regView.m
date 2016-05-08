//
//  regView.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "regView.h"

#define daojishiSecond 120
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
    _secondsCountDown = daojishiSecond;
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
    _sureSmsTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.ensurePwStr.frame), CGRectGetMaxY(self.ensurePwStr.frame)+10, CGRectGetWidth(self.ensurePwStr.frame)-100, CGRectGetHeight(self.ensurePwStr.frame))];
    _sureSmsTf.backgroundColor = [UIColor greenColor];
    _sureSmsTf.placeholder = @"请输入验证码";
    _sureSmsTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sureSmsTf.borderStyle = UITextBorderStyleRoundedRect;
    _sureSmsTf.keyboardType = UIKeyboardTypeNumberPad;
    //_sureSmsTf.delegate = self;
    [self addSubview:_sureSmsTf];
     _smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _smsBtn.frame = CGRectMake(CGRectGetMaxX(self.ensurePwStr.frame)-95, CGRectGetMaxY(self.ensurePwStr.frame)+10, 95, CGRectGetHeight(self.ensurePwStr.frame));
    //    [smsButton setAttributedTitle:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    _smsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_smsBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    _smsBtn.backgroundColor = [UIColor cyanColor];
    [_smsBtn addTarget:self action:@selector(getSms:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_smsBtn];

    
    // 注册按钮
    
    self.regBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    self.regBtn.frame = CGRectMake(0, CGRectGetMaxY(self.smsBtn.frame)+20, kScreenWidth, 50);
    self.regBtn.backgroundColor = [UIColor blueColor];
    
    [self.regBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.regBtn.tintColor = [UIColor whiteColor];
    [self addSubview:_regBtn];

}
//获取验证码
- (void)getSms:(UIButton *)sender{
    [self.timer fire];//倒计时按钮
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.userName.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
        }
    }];
}
- (NSTimer *)timer{
    if (_timer) {
        return _timer;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(biaoti) userInfo:nil repeats:YES];
    return _timer;
}

//定时器方法
- (void)biaoti{
    _smsBtn.userInteractionEnabled = NO;
    _secondsCountDown --;
    [_smsBtn setTitle:[NSString stringWithFormat:@"请%lds后重试", _secondsCountDown] forState:UIControlStateNormal];
    if (_secondsCountDown == 0) {
        _smsBtn.userInteractionEnabled = YES;
        _secondsCountDown = daojishiSecond;
        [self.timer invalidate];
        self.timer = nil;
        [_smsBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
