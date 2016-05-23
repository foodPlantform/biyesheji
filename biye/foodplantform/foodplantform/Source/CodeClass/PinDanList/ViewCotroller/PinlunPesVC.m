//
//  PinlunPesVC.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/23.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "PinlunPesVC.h"
#import "OldPindDanVC.h"
#import "PinlunSenderVC.h"
#import "SUNSlideSwitchView.h"
@interface PinlunPesVC ()<SUNSlideSwitchViewDelegate>
@property (nonatomic,strong)SUNSlideSwitchView *pinlunPesMenuView;
@property (nonatomic,strong)NSArray *pinlunPesArr;

@end

@implementation PinlunPesVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //订单
    _pinlunPesMenuView = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-44-20)];
   // _pinlunPesMenuView.backgroundColor  = [UIColor yellowColor];
    self.pinlunPesMenuView.dataArr = @[@"拼单评价",@"发单人评价"];
    self.pinlunPesMenuView.slideSwitchViewDelegate =self;
    
    OldPindDanVC *oldPindDanVC = [[OldPindDanVC alloc ] init];
    oldPindDanVC.userID = _userID;
    PinlunSenderVC * pinlunSenderVC = [[PinlunSenderVC alloc] init];
    pinlunSenderVC.userID = _userID;
    _pinlunPesArr = @[oldPindDanVC,pinlunSenderVC];
    [self.pinlunPesMenuView buildUI];
    [self.view addSubview:_pinlunPesMenuView];
}
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return  _pinlunPesArr[number];
}
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return _pinlunPesArr.count;
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
