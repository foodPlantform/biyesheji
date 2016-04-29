//
//  loginViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "loginViewController.h"
#import "loginView.h"
#import "regViewController.h"
@interface loginViewController ()
@property(nonatomic,strong)loginView *lv;
@end

@implementation loginViewController
-(void)loadView
{
    self.lv = [[loginView alloc]init];
    self.view = _lv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    [self.lv.regBtn addTarget:self action:@selector(regAction) forControlEvents:UIControlEventTouchUpInside];
    [self.lv.loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)leftAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)regAction
{
    regViewController *regVc = [[regViewController alloc]init];
    //UINavigationController *regNc = [[UINavigationController alloc]initWithRootViewController:regVc];
    [self.navigationController pushViewController:regVc animated:YES];
}

// 点击登陆事件
-(void)loginBtnAction
{
    if ([self.lv.userName.text isEqualToString:@""] || [self.lv.pwStr.text isEqualToString:@""]) {
        [[regAndLogTool shareTools] messageShowWith:@"请输入完整内容" cancelStr:@"确定"];
    }
    else
    {
        if ([[[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text] isEqualToString:@"成功"]) {
            NSLog(@"登陆成功");
            
        }
        else if ([[[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text] isEqualToString:@"用户名不存在"])
        {
            NSLog(@"用户名不存在");
        }
        else if ([[[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text] isEqualToString:@"失败"])
        {
            NSLog(@"登陆失败");
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
