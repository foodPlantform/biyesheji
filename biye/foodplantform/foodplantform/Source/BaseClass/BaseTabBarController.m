//
//  BaseTabBarController.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "BaseTabBarController.h"
#import "AddressListViewController.h"
#import "MessageViewController.h"
#import "foodlistTableViewController.h"
#import "mineTableViewController.h"
#import "PinDanVcr.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首页
   
    
    PinDanVcr *pindanVcr = [[PinDanVcr alloc] init];
    [self setUpOneChildViewController:pindanVcr image:[UIImage imageNamed:@"首页"] title:@"首页"];

    //美食
    foodlistTableViewController *foodlistVc = [[foodlistTableViewController alloc]init];
    [self setUpOneChildViewController:foodlistVc image:[UIImage imageNamed:@"美食1"]  title:@"美食"];
    
       //消息界面
    MessageViewController * messageVC = [[MessageViewController alloc]init];
    [self setUpOneChildViewController:messageVC image:[UIImage imageNamed:@"消息"] title:@"消息"];
    
    //通讯录界面
    AddressListViewController * addressListVC = [[AddressListViewController alloc]init];
    [self setUpOneChildViewController:addressListVC image:[UIImage imageNamed:@"通讯录"] title:@"通讯录"];
    


    //我的
    mineTableViewController *mineVC = [[mineTableViewController alloc]init];
    [self setUpOneChildViewController:mineVC image:[UIImage imageNamed:@"我的"] title:@"我的"];
}

/**
 * 添加一个子控制器的方法
 */
-(void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    UINavigationController * naVC = [[UINavigationController alloc]initWithRootViewController:viewController];
    naVC.title = title;//设置Tabbar的标题
    naVC.tabBarItem.image = image;//设置tabbar的图片
    viewController.navigationItem.title = title;//设置界面的navigationbar的标题
    [self addChildViewController:naVC];
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
