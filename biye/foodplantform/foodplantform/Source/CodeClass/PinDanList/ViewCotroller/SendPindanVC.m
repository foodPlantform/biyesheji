//
//  SendPindanVC.m
//  foodplantform
//
//  Created by 仇亚利 on 16/4/23.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "SendPindanVC.h"
#define PinDanCellJianJu 20

@interface SendPindanVC ()


//拼单人数
@property(nonatomic,strong)UILabel *foodPersonNumLB;


@property(nonatomic,strong)UITextField *foodPersonNumTf;
//拼单食物名字
@property(nonatomic,strong)UILabel *foodNameLB;
@property(nonatomic,strong)UITextField *foodNameTf;

//拼单对象
@property(nonatomic,strong)UILabel *foodPersonLB;
@property(nonatomic,strong)UITextField *foodPersonLBTf;

//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
@property(nonatomic,strong)UITextField *foodTimeTf;

//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;
@property(nonatomic,strong)UITextField *foodLocationTf;


@end

@implementation SendPindanVC

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UIBarButtonItem *rightSendItem = [[UIBarButtonItem alloc] initWithTitle:@"确定发单" style:UIBarButtonItemStylePlain target:self action:@selector(sendItemBtnAction)];
    self.navigationItem.rightBarButtonItem = rightSendItem;
    
    
    [self set_UpSendPindanView];
    
    

}

- (void)set_UpSendPindanView
{
    
    
    _foodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, 64+PinDanCellJianJu*2, kScreenWidth/3.0, 10)];
    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 : "] ;
    
    [self.view addSubview:_foodNameLB];
    
    
    _foodNameTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_foodNameLB.frame), CGRectGetMinY(_foodNameLB.frame)-10, kScreenWidth/3.0+20, 30)];
    
//    _foodNameTf.center = CGPointMake(CGRectGetMaxX(_foodNameTf.frame)+CGRectGetWidth(_foodNameTf.frame)/2.0, (CGRectGetMinY(_foodNameTf.frame)+CGRectGetMaxY(_foodNameTf.frame))/2.0);
    _foodNameTf.font = [UIFont boldSystemFontOfSize:16] ;
//    [_foodNameTf setValue:[UIFont boldSystemFontOfSize:3] forKeyPath:@"_placeholderLabel.font"];

    _foodNameTf.placeholder = @"请输入您想吃的美食";
    [self.view addSubview:_foodNameTf];
    _foodPersonLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodNameLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    
    _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象: "] ;
    
    [self.view addSubview:_foodPersonLB];
    
    _foodPersonLBTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodPersonLB.frame)-10, kScreenWidth/3.0+20, 30)];
    
    
    _foodPersonLBTf.placeholder = @"请输入您想约的对象";
    [self.view addSubview:_foodPersonLBTf];
    
    _foodPersonNumLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodPersonLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    
    _foodPersonNumLB.text = [NSString stringWithFormat:@"约吃人数: "] ;
    
    [self.view addSubview:_foodPersonNumLB];
    _foodPersonNumTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodPersonNumLB.frame)-10, kScreenWidth/3.0+20, 30)];
    
    
    _foodPersonNumTf.placeholder = @"请输入您想约的人数";
    [self.view addSubview:_foodPersonNumTf];

    
    _foodTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodPersonNumLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame),10)];
    _foodTimeLB.text = [NSString stringWithFormat:@"约吃时间: "] ;
    
    [self.view addSubview:_foodTimeLB];
    
    _foodTimeTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodTimeLB.frame)-10, kScreenWidth/3.0+20, 30)];
    
    
    _foodTimeTf.placeholder = @"请输入您想约的时间";
    [self.view addSubview:_foodTimeTf];

    
    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    _foodLocationLB.text = [NSString stringWithFormat:@"我要地点: "] ;
    
    [self.view addSubview:_foodLocationLB];

    
    _foodLocationTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodLocationLB.frame)-10, kScreenWidth/3.0+20, 30)];
    
    
    _foodLocationTf.placeholder = @"请输入您想约的地点";
    [self.view addSubview:_foodLocationTf];

}
#pragma mark - 发布 按钮
- (void)sendItemBtnAction
{
    if (0!=_foodLocationTf.text.length&&0!=_foodPersonLBTf.text.length&&0!=_foodPersonNumTf.text.length&&0!=_foodTimeTf.text.length&&0!=_foodNameTf.text.length)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
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
