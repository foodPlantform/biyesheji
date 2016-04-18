//
//  BaseViewController.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示菊花
- (void)startHud {
    _BasicHud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    _BasicHud.textLabel.text = @"加载中...";
    [_BasicHud showInView:self.view];
}

//隐藏菊花
- (void)stopHud {
    [_BasicHud dismiss];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
