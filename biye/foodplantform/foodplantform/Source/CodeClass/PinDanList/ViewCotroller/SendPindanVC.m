//
//  SendPindanVC.m
//  foodplantform
//
//  Created by 仇亚利 on 16/4/23.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "KCMainViewController.h"

#import "DateHelper.h"
#import "NSDate+CalculateDay.h"
#import "KMDatePicker.h"
#import "SendPindanVC.h"
#define PinDanCellJianJu 20

@interface SendPindanVC ()<UITextFieldDelegate,KCLocationLongPressToDoDelegate,KMDatePickerDelegate>


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


@property(nonatomic,strong)CLPlacemark *placeMark;

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
    _foodNameTf.delegate =self;
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
    
    _foodTimeTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodTimeLB.frame)-10, kScreenWidth/2.0+20, 30)];
    _foodTimeTf.font = [UIFont systemFontOfSize:17];

    _foodTimeTf.delegate = self;
    _foodTimeTf.tag = 1000;
    _foodTimeTf.placeholder = @"请输入您想约的时间";
    [self.view addSubview:_foodTimeTf];

    
    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    _foodLocationLB.text = [NSString stringWithFormat:@"约吃地点: "] ;
    
    [self.view addSubview:_foodLocationLB];

    
    _foodLocationTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodLocationLB.frame)-10, kScreenWidth/2.0+20, 30)];
    _foodLocationTf.font = [UIFont systemFontOfSize:17];
    _foodLocationTf.delegate = self;
    _foodLocationTf.tag = 1001;
    _foodLocationTf.placeholder = @"点击获取地址";
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
    
    [self sendOrder];

}
#pragma mark - 发布订单
- (void)sendOrder
{
    //往GameScore表添加一条user_order为小明，分数为78的数据
    BmobObject *user_order = [BmobObject objectWithClassName:@"user_order"];
    [user_order setObject:[NSNumber numberWithInteger:_foodPersonNumLB.text.integerValue] forKey:@"order_num"];
    [user_order setObject:_foodNameTf.text forKey:@"order_name"];

    [user_order setObject:_foodPersonLBTf.text forKey:@"order_target"];

    [user_order setObject:nil forKey:@"order_time"];
    [user_order setObject:nil forKey:@"order_loaction"];

   // [user_order setObject:@78 forKey:@"score"];
    [user_order saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        NSLog(@"error----------%@",error);
        NSLog(@"isSuccessful--------%d",isSuccessful);
    }];

}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1000)
    {
        [self set_upTimePicker];
    }}

#pragma mark - 用户是否可以编辑
//用户是否可以编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1001) {
        
        KCMainViewController *vc =[[KCMainViewController alloc ] init];
        vc.delegate = self;
        vc.navigationItem.title = @"长按选择地址";
         vc.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:YES];
        _foodLocationTf.font = [UIFont systemFontOfSize:12];

        return NO;
    }
    else
    {
        return YES;
    }
}
#pragma mark - KCMainViewControllerdelegate
-(void)KCMainViewControllerLongProessGetLoaction:(NSString *)longPressPlacemarkStr place:(CLPlacemark *)placeMark
{
    _foodLocationTf.text = longPressPlacemarkStr;
    
    
    _placeMark = placeMark;
    NSLog(@"----------%@",placeMark);
}
#pragma mark - KMDatePickerdelegate

- (void)set_upTimePicker
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0.0, 0.0, rect.size.width, 216.0);
    // 年月日时分
    KMDatePicker *datePicker = [[KMDatePicker alloc]
                                initWithFrame:rect
                                delegate:self
                                datePickerStyle:KMDatePickerStyleYearMonthDayHourMinute];
    _foodTimeTf.inputView = datePicker;
    
}
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(KMDatePickerDateModel *)datePickerDate
{
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@ %@",
                         datePickerDate.year,
                         datePickerDate.month,
                         datePickerDate.day,
                         datePickerDate.hour,
                         datePickerDate.minute,
                         datePickerDate.weekdayName
                         ];
    _foodTimeTf.font = [UIFont systemFontOfSize:12];

    _foodTimeTf.text = dateStr;

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
