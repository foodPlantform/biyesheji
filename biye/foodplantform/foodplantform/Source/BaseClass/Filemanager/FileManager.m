//
//  FileManager.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/7.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "FileManager.h"
static FileManager *_manager;
@implementation FileManager
+(FileManager *)shareManager
{
    static dispatch_once_t once_Token;
    if (_manager == nil) {
        dispatch_once(&once_Token, ^{
            _manager = [[FileManager alloc]init];
        });
    }
    return _manager;
}
//用户是否登陆了
-(BOOL)isUserLogin
{
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        //进行操作
        return YES;
    }else{
        //对象为空时，可打开用户注册界面
        return NO;
    }
     
}
//没有登陆 跳到登陆界面
- (void)LoginWithVc:(UIViewController *)vc
{
    // 1.跳出弹出框，提示用户打开步骤。
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有登陆，请登录" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        loginViewController *loginVc = [[loginViewController alloc] init];
        [vc.navigationController pushViewController:loginVc animated:YES];
    }]];
    [vc presentViewController:alertController animated:YES completion:nil];
    
}

@end
