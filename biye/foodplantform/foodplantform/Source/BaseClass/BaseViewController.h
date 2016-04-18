//
//  BaseViewController.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

//公共基类，以后创建所有的页面都要继承此Controller，在这里放所有的公共的方法，比如显示菊花
@interface BaseViewController : UIViewController

//小菊花，写成属性
@property (nonatomic, strong) JGProgressHUD *BasicHud;

//显示菊花
- (void)startHud;
//隐藏菊花
- (void)stopHud;

@end
