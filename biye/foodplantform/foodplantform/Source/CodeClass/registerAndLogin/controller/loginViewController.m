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
