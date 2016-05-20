//
//  allpinglunViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/19.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "allpinglunViewController.h"
#import "pinglunController.h"
#import "userPinglun.h"

@interface allpinglunViewController ()
@property(nonatomic,strong) UISegmentedControl *seg;
@property(nonatomic,strong)pinglunController *pingVc;
@property(nonatomic,strong) userPinglun *userVc;

@end

@implementation allpinglunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pingVc = [[pinglunController alloc]init];
    self.pingVc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self addChildViewController:_pingVc];
    
    self.userVc  = [[userPinglun alloc]init];
    [self addChildViewController:_userVc];
    self.userVc.view.frame = CGRectMake(0, 66, kScreenWidth, kScreenHeight);
    
    NSMutableArray *arr=  [NSMutableArray arrayWithObjects:@"订单评价",@"用户评价", nil];
    
    self.seg = [[UISegmentedControl alloc]initWithItems:arr];
    self.navigationItem.titleView = _seg;
    [self.seg addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    self.seg.selectedSegmentIndex = 0;
    
    [self.view addSubview:_pingVc.view];
    // Do any additional setup after loading the view.
}
-(void)changeAction:(UISegmentedControl *)sender
{


    if (sender.selectedSegmentIndex == 0) {
        [UIView transitionFromView:_userVc.view toView:_pingVc.view duration:0.1 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
    }
    if (sender.selectedSegmentIndex == 1) {
        [UIView transitionFromView:_pingVc.view toView:_userVc.view duration:0.1 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
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
