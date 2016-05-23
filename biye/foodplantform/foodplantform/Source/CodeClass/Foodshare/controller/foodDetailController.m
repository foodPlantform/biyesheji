//
//  foodDetailController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "foodDetailController.h"
#import "SUNSlideSwitchView.h"

#import "pinglunViewController.h"
#import "orderFoodViewController.h"
#import "userMessageViewController.h"
#import "userPingLunViewController.h"

@interface foodDetailController ()<SUNSlideSwitchViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *pic;
@property (strong,nonatomic)SUNSlideSwitchView *menuView;
@property(nonatomic,strong)NSArray * arr;
@end

@implementation foodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_scrollView];
    self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    [self.scrollView addSubview:_pic];
    [self.pic sd_setImageWithURL:[NSURL URLWithString:self.foodmodel.picUrl]];
    self.menuView = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight)];
    
    self.menuView.dataArr = @[@"点餐",@"订单评论",@"用户评论",@"用户"];
    self.menuView.slideSwitchViewDelegate =self;
    [self.scrollView addSubview:self.menuView];
    pinglunViewController *pinglunVc = [[pinglunViewController alloc]init];
    pinglunVc.foodmodel_pinglun = self.foodmodel;
    
    userMessageViewController *userVc = [[userMessageViewController alloc]init];
    userVc.foodmodel_user = self.foodmodel;
    
    orderFoodViewController *ordVc = [[orderFoodViewController alloc]init];
    ordVc.parentVc = self;
    ordVc.foodmodel_ord = [[foodModel alloc]init];
    ordVc.foodmodel_ord = self.foodmodel;
    
    userPingLunViewController *userpinglunVc = [[userPingLunViewController alloc]init];
    userpinglunVc.foodmodel_userpinglun = self.foodmodel;
    
    self.arr = [NSArray arrayWithObjects:ordVc,pinglunVc,userpinglunVc,userVc, nil];
    //[self.menuView.viewArray addObjectsFromArray:_arr];
    [self.menuView buildUI];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+150);
    NSLog(@"name%@",self.foodmodel.foodName);
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 4;
}
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return self.arr[number];
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
