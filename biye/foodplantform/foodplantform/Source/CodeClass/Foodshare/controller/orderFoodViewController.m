//
//  orderFoodViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "orderFoodViewController.h"
#import "orderView.h"
#import "addressViewController.h"
#import "foodDetailController.h"
#import "AppDelegate.h"
#import "loginViewController.h"
#import "chooseTimeViewController.h"

@interface orderFoodViewController ()
@property(nonatomic,strong)orderView *ov;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,strong)NSString *ID;
@end

@implementation orderFoodViewController
-(void)loadView
{
    self.ov = [[orderView alloc]init];
    self.view = _ov;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_data];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.ov.add addTarget:self action:@selector(addNumAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ov.sub addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ov.sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    self.ov.resultName.text = self.foodmodel_ord.foodName;
    self.ov.resultNum.text = @"0份";
    self.num = 0;
    NSLog(@"%@===",_foodmodel_ord.phone);
   
    // Do any additional setup after loading the view.
}
-(void)addNumAction
{
    if (self.num<0) {
        return;
    }
    else
    {
        self.num+=1;
        self.ov.count.text  = [NSString stringWithFormat:@"%ld",(long)self.num];
        self.ov.resultNum.text = [NSString stringWithFormat:@"%ld份",(long)self.num];
    }
}
-(void)subAction
{
    if (self.num<=0) {
        return;
    }
    else
    {
        self.num-=1;
        self.ov.count.text = [NSString stringWithFormat:@"%ld",(long)self.num];
        self.ov.resultNum.text = [NSString stringWithFormat:@"%ld份",(long)self.num];
    }
}
-(void)p_data
{
    self.ov.foodName.text = self.foodmodel_ord.foodName;
    self.ov.fooddes.text = self.foodmodel_ord.foodDes;
    self.ov.rec.text = self.foodmodel_ord.rec;
    self.ov.sty.text = self.foodmodel_ord.sty;
}
-(void)sureAction
{
    
    if ([regAndLogTool shareTools].loginName == nil) {
        loginViewController *loginVc = [[loginViewController alloc]init];
        UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self.navigationController presentViewController:na animated:YES completion:^{
            
        }];
        
    }
    else
    {
        BmobUser *user = [BmobUser getCurrentUser];
        if ([user.mobilePhoneNumber isEqualToString:self.foodmodel_ord.phone]) {
            
            [[regAndLogTool shareTools] messageShowWith:@"自己的上传,不能预订" cancelStr:@"确定"];
            return;
        }
       
       else if ([self.ov.resultNum.text  isEqualToString:@""] || [self.ov.resultNum.text isEqualToString:@"0份"])
       {
            [[regAndLogTool shareTools] messageShowWith:@"请选择份数" cancelStr:@"确定"];
            return;
        }
        else if ([self.foodmodel_ord.rec isEqualToString:@"不接受预订"])
        {
            [[regAndLogTool shareTools] messageShowWith:@"不接受预订" cancelStr:@"确定"];
            return;
        }
        else if ([self.foodmodel_ord.sty isEqualToString:@"堂食"])
        {
            //[[regAndLogTool shareTools] messageShowWith:@"预订成功" cancelStr:@"确定"];
            chooseTimeViewController *chVc =  [[chooseTimeViewController alloc]init];
            [self.parentVc.navigationController pushViewController:chVc animated:YES];
        }
        else
        {
            addressViewController *addVc = [[addressViewController alloc]init];
            addVc.foodID  = self.foodmodel_ord.fid;
            addVc.phone = self.foodmodel_ord.phone;
            [_parentVc.navigationController pushViewController:addVc animated:YES];
            [_parentVc setHidesBottomBarWhenPushed:YES];

        }
        
    }
    
    
   //    UITabBarController *tabViewController = (UITabBarController *) app.window.rootViewController;
//    [tabViewController.navigationController pushViewController:addVc animated:YES];
//    foodDetailController *foodVc = [[foodDetailController alloc]init];
//    [foodVc.navigationController pushViewController:addVc animated:YES];
//    UINavigationController *addNc = [[UINavigationController alloc]initWithRootViewController:addVc];
//    [self.navigationController presentViewController:addNc animated:YES completion:^{
//        
//    }];
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
