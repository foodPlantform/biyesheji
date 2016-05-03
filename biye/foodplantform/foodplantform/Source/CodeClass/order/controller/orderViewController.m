//
//  orderViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/3.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "orderViewController.h"
#import "doneOrderTableViewController.h"
#import "undoOrderTableViewController.h"
@interface orderViewController ()
@property(nonatomic,strong)undoOrderTableViewController *undoVc;
@property(nonatomic,strong)doneOrderTableViewController *doneVc;
@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加子controller
    _undoVc =[[undoOrderTableViewController alloc]init];
    _undoVc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self addChildViewController:_undoVc];
    _doneVc =[[doneOrderTableViewController alloc]init];
    _doneVc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    [self addChildViewController:_doneVc];
    
    [self.view addSubview:_undoVc.view];
    
    
    // seg控件
    self.seg = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"未处理",@"已处理", nil]];
    self.navigationItem .titleView = _seg;
    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.
}
-(void)segAction:(id)sender
{
    if ([self.seg selectedSegmentIndex] == 0) {
        [UIView transitionFromView:_doneVc.view toView:_undoVc.view duration:0.1 options:UIViewAnimationOptionAutoreverse completion:nil];
    }
    else
    {
        [UIView transitionFromView:_undoVc.view toView:_doneVc.view duration:0.1 options:UIViewAnimationOptionAutoreverse completion:nil];
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
