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
#import "OrderVC.h"
#import "SUNSlideSwitchView.h"
@interface orderViewController ()<SUNSlideSwitchViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)undoOrderTableViewController *undoVc;
@property(nonatomic,strong)doneOrderTableViewController *doneVc;

@property (nonatomic,strong)OrderVC *orderVc;

@property (nonatomic,strong)SUNSlideSwitchView *orderMenuView;
@property (nonatomic,strong)SUNSlideSwitchView *foodMenuView;
@property (nonatomic,strong)UIScrollView *menuScrollView;
@end

@implementation orderViewController
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
    
    // 添加子controller
//    _undoVc =[[undoOrderTableViewController alloc]init];
//    _undoVc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    [self addChildViewController:_undoVc];
//    _doneVc =[[doneOrderTableViewController alloc]init];
//    _doneVc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
//    [self addChildViewController:_doneVc];
//    
//    [self.view addSubview:_undoVc.view];
//    
    
//    // seg控件
//    self.seg = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"订单",@"美食", nil]];
//    self.navigationItem .titleView = _seg;
//    _seg.selectedSegmentIndex = 0;
//    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [self loadSubviews];
    // Do any additional setup after loading the view.
}
- (void)loadSubviews{
    _menuScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_menuScrollView];
    _menuScrollView.delegate = self;
    _menuScrollView.contentSize = CGSizeMake(_menuScrollView.frame.size.width*2, _menuScrollView.frame.size.height);
    
    _menuScrollView.pagingEnabled = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"拼单",@"美食"]];
    
   
    self.navigationItem.titleView = self.seg;
    self.seg.selectedSegmentIndex = 0;
    [self.seg addTarget:self action:@selector(segmentControlPageChange:) forControlEvents:UIControlEventValueChanged];
    //订单
    _orderMenuView = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-44-20)];
    _orderMenuView.tag = 0;
    self.orderMenuView.dataArr = @[@"已发布拼单",@"已完成拼单",@" 待处理拼单",@"已处理拼单",@"待审核拼单",@"已审核拼单"];
    self.orderMenuView.slideSwitchViewDelegate =self;
    [self.menuScrollView addSubview:self.orderMenuView];
    [self.orderMenuView buildUI];
    //美食
    _foodMenuView = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(kScreenWidth, 64, kScreenWidth, kScreenHeight-44-20)];
    _foodMenuView.tag = 1;
    _foodMenuView.dataArr = @[@"已发布拼单",@"已完成拼单",@"已处理拼单",@"待处理拼单",@"待审核拼单",@"已审核拼单"];
    _foodMenuView.slideSwitchViewDelegate =self;
    [self.menuScrollView addSubview:_foodMenuView];
    [_foodMenuView buildUI];
    
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.seg.selectedSegmentIndex = page;
}

#pragma mark - segmentControl的点击事件
- (void)segmentControlPageChange:(UISegmentedControl *)sender{
    [_menuScrollView setContentOffset:CGPointMake(_menuScrollView.frame.size.width*sender.selectedSegmentIndex, 0) animated:YES];
}

#pragma mark - SUNSlideSwitchViewDelegate

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return  view.tag ==0?_orderMenuView.dataArr.count:_foodMenuView.dataArr.count;
}
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{

    if (view.tag == 0) {
        _doneVc =[[doneOrderTableViewController alloc]init];
        _doneVc.orderType = [NSString stringWithFormat:@"%lu",(unsigned long)number];
        return _doneVc;
    }else
    {
        return _doneVc;
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
