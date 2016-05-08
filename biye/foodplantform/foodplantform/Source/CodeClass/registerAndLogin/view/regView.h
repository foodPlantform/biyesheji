//
//  regView.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface regView : UIView

@property(nonatomic,strong)UITextField *userName;

@property(nonatomic,strong)UITextField *pwStr;

@property(nonatomic,strong)UITextField *ensurePwStr;
@property(nonatomic,strong)UIButton *regBtn;
//短信验证码
@property(nonatomic,strong)UIButton *smsBtn;
@property(nonatomic,strong)UITextField *sureSmsTf;


//定时器
@property (nonatomic, retain) NSTimer *timer;
//定时器倒计时
@property (nonatomic, assign) NSInteger secondsCountDown;

@end
