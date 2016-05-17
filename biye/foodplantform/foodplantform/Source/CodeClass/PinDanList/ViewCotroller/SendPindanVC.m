//
//  SendPindanVC.m
//  foodplantform
//
//  Created by 仇亚利 on 16/4/23.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "KCMainViewController.h"
#import "KMDatePickerView.h"
#import "DateHelper.h"
#import "NSDate+CalculateDay.h"
#import "KMDatePicker.h"
#import "SendPindanVC.h"
#import "LrdOutputView.h"
#define PinDanCellJianJu 20
#define PinDanPayTypeTag 103
#define PinDanLocationTag 100
#define PinDanTimeTag 101
#define PinDanTargetTag 102

@interface SendPindanVC ()<UITextFieldDelegate,KCLocationLongPressToDoDelegate,KMDatePickerDelegate,LrdOutputViewDelegate>


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
@property(nonatomic,strong) UIButton *foodLocationBtn;

//拼单付款方式
@property(nonatomic,strong)UILabel *foodPayTypeLB;
@property(nonatomic,strong)UITextField *foodPayTypeTf;

@property(nonatomic,strong)CLPlacemark *placeMark;
//后端地理位置
@property(nonatomic,strong)BmobGeoPoint*bmobGeoPoint;

@property(nonatomic,strong)NSString*loactionStr;
@property(nonatomic,strong)NSString*headUrlStr;
@property(nonatomic,strong)NSString*userNameStr;

@property(nonatomic,strong)NSDate*bmobOrderDate;
//拼单付款方式
@property(nonatomic,assign)NSInteger foodPayTypeRow;
//拼单对象
@property(nonatomic,assign)NSInteger foodTargetRow;

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
    [self sendPindanProgressHud];
    _sendPindanHud.hidden =YES;
}
// 第三方小菊花
- (void)sendPindanProgressHud
{
    self.sendPindanHud = [[MBProgressHUD alloc] initWithView:self.view];
    _sendPindanHud.frame = self.view.bounds;
    _sendPindanHud.minSize = CGSizeMake(100, 100);
    _sendPindanHud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_sendPindanHud];
    
   [_sendPindanHud show:YES];
}

- (void)set_UpSendPindanView
{
    
    
    _foodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, 64+PinDanCellJianJu*2, kScreenWidth/3.0, 10)];
    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 : "] ;
    
    [self.view addSubview:_foodNameLB];
    
    
    _foodNameTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_foodNameLB.frame), CGRectGetMinY(_foodNameLB.frame)-10, kScreenWidth/3.0+20, 30)];
    _foodNameTf.delegate = self;
    
//    _foodNameTf.center = CGPointMake(CGRectGetMaxX(_foodNameTf.frame)+CGRectGetWidth(_foodNameTf.frame)/2.0, (CGRectGetMinY(_foodNameTf.frame)+CGRectGetMaxY(_foodNameTf.frame))/2.0);
    _foodNameTf.font = [UIFont boldSystemFontOfSize:16] ;
//    [_foodNameTf setValue:[UIFont boldSystemFontOfSize:3] forKeyPath:@"_placeholderLabel.font"];

    _foodNameTf.placeholder = @"请输入您想吃的美食";
    //_foodNameTf.delegate =self;
    [self.view addSubview:_foodNameTf];
    _foodPersonLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodNameLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    
    _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象: "] ;
    
    [self.view addSubview:_foodPersonLB];
    
    _foodPersonLBTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodPersonLB.frame)-10, kScreenWidth/3.0+20, 30)];
    _foodPersonLBTf.delegate = self;
    _foodPersonLBTf.tag = PinDanTargetTag;
    _foodPersonLBTf.placeholder = @"点击选择您想约的对象";
    [self.view addSubview:_foodPersonLBTf];
    
    _foodPersonNumLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodPersonLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    
    _foodPersonNumLB.text = [NSString stringWithFormat:@"拼单人数: "] ;
    [self.view addSubview:_foodPersonNumLB];
    _foodPersonNumTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodPersonNumLB.frame)-10, kScreenWidth/3.0+20, 30)];
    _foodPersonNumTf.keyboardType=UIKeyboardTypeNumberPad;
    _foodPersonNumTf.delegate =self;
    _foodPersonNumTf.placeholder = @"请输入您想约的人数";
    [self.view addSubview:_foodPersonNumTf];

    _foodPayTypeLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodPersonNumLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame),10)];
    _foodPayTypeLB.text = [NSString stringWithFormat:@"拼单方式: "] ;
    
    [self.view addSubview:_foodPayTypeLB];
    
    _foodPayTypeTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodPayTypeLB.frame)-10, kScreenWidth/2.0+20, 30)];
    _foodPayTypeTf.font = [UIFont systemFontOfSize:17];
    
    _foodPayTypeTf.delegate = self;
    _foodPayTypeTf.tag = PinDanPayTypeTag;
    _foodPayTypeTf.placeholder = @"点击选择拼单付款方式";
    [self.view addSubview:_foodPayTypeTf];
    _foodTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodPayTypeLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame),10)];
    _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间: "] ;
    
    [self.view addSubview:_foodTimeLB];
    
    _foodTimeTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodTimeLB.frame)-10, kScreenWidth/2.0+20, 30)];
    _foodTimeTf.font = [UIFont systemFontOfSize:17];

    _foodTimeTf.delegate = self;
    _foodTimeTf.tag = PinDanTimeTag;
    _foodTimeTf.placeholder = @" 点击获取您想约的时间";
    [self.view addSubview:_foodTimeTf];

    
    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu*2, CGRectGetWidth(_foodNameLB.frame), 10)];
    _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点: "] ;
    
    [self.view addSubview:_foodLocationLB];

    
//    _foodLocationTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodLocationLB.frame)-10, kScreenWidth/2.0+20, 30)];
//    _foodLocationTf.font = [UIFont systemFontOfSize:17];
//    _foodLocationTf.delegate = self;
//    _foodLocationTf.tag = PinDanLocationTag;
//    _foodLocationTf.placeholder = @"点击获取地址";
//    [self.view addSubview:_foodLocationTf];
    _foodLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameTf.frame), CGRectGetMinY(_foodLocationLB.frame)-10, kScreenWidth/2.0+20, 30)];
    [_foodLocationBtn addTarget:self action:@selector(getLocationStr) forControlEvents:UIControlEventTouchUpInside];
    [_foodLocationBtn setTitleColor:[UIColor blackColor] forState:0];
    [_foodLocationBtn setTitle:@"点击获取地址" forState:0];
    _foodLocationBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];

    [self.view addSubview:_foodLocationBtn];

}
#pragma mark - 获取地理位置
-(void)getLocationStr
{
    KCMainViewController *vc =[[KCMainViewController alloc ] init];
    vc.delegate = self;
    vc.navigationItem.title = @"长按选择地址";
    vc.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - 发布 按钮
- (void)sendItemBtnAction
{
    if ([[FileManager shareManager] isUserLogin]) {
        //注销登陆  [BmobUser logout];
        if (0!=_foodNameTf.text.length&&0!=_foodPersonLBTf.text.length&&0!=_foodPersonNumTf.text.length&&0!=_foodTimeTf.text.length&&0!=[_foodLocationBtn currentTitle].length)
        {
            // [self.navigationController popViewControllerAnimated:YES];
            BmobUser *bUser = [BmobUser getCurrentUser];
            BmobQuery *query = [BmobUser query];
            [query whereKey:@"objectId" equalTo:bUser.objectId];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                _headUrlStr = [array[0] objectForKey:@"head_img"];
                
                _userNameStr = [array[0] objectForKey:@"username"];
                
                // 发单
                [self sendOrder];
                
            }];

        }
        else
        {
            // 1.跳出弹出框，提示用户打开步骤。
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@" 选项不能为空" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }

        
    }else
    {
        [[FileManager shareManager ] LoginWithVc:self];
    }
    
    
}
#pragma mark - 发布订单
- (void)sendOrder
{
    _sendPindanHud.hidden = NO;
    //往GameScore表添加一条user_order为小明，分数为78的数据
    
    BmobUser *bUser = [BmobUser getCurrentUser];
    
    BmobObject *user_order = [BmobObject objectWithClassName:@"user_order"];
    [user_order setObject:_headUrlStr forKey:@"user_headUrl"];
    [user_order setObject:_userNameStr forKey:@"order_userName"];

    [user_order setObject:bUser.objectId forKey:@"order_senderID"];
    [user_order setObject:@1 forKey:@"order_currentNum"];
    [user_order setObject:[NSNumber numberWithInteger:_foodPersonNumTf.text.integerValue] forKey:@"order_maxNum"];
    [user_order setObject:_foodNameTf.text forKey:@"order_name"];

    [user_order setObject:[NSString stringWithFormat:@"%ld",(long)_foodTargetRow ]  forKey:@"order_target"];

    [user_order setObject:_bmobOrderDate forKey:@"order_time"];
    [user_order setObject:_loactionStr forKey:@"order_locationStr"];

    [user_order setObject:_bmobGeoPoint forKey:@"order_loaction"];
    [user_order setObject:[NSString stringWithFormat:@"%ld",(long)_foodPayTypeRow ] forKey:@"order_payType"];

   // [user_order setObject:@78 forKey:@"score"];
    [user_order saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
//        NSLog(@"error----------%@",error);
//        NSLog(@"isSuccessful--------%d",isSuccessful);
        _sendPindanHud.hidden = YES;
        // 1.跳出弹出框，提示用户打开步骤。
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你发送拼单情况" message:isSuccessful==1?@"发步成功":@"发布失败请重新发布"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _foodNameTf.text = nil;
            [_foodLocationBtn setTitle:@" 点击获取地址" forState:0] ;
            _foodTimeTf.text = nil;
            _foodPayTypeTf.text = nil;
            _foodPersonLBTf.text = nil;
            _foodPersonNumTf.text = nil;
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
}
#pragma mark - UITextFieldDelegate 选择时间 和付款方式
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == PinDanTimeTag)//时间
    {
        [self set_upTimePicker];

    }else if (textField.tag == PinDanLocationTag) {
        
        KCMainViewController *vc =[[KCMainViewController alloc ] init];
        vc.delegate = self;
        vc.navigationItem.title = @"长按选择地址";
        vc.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:YES];
        _foodLocationTf.font = [UIFont systemFontOfSize:12];
        
        
    }
    else  if (textField.tag ==PinDanPayTypeTag)
    {
        LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"我付",@"AA制"] origin:CGPointMake(CGRectGetMinX(_foodPayTypeTf.frame), CGRectGetMaxY(_foodPayTypeTf.frame)-10) width:125 height:44 direction:kLrdOutputViewDirectionRight];
        _outputView.tag = PinDanPayTypeTag;
        _outputView.delegate = self;
        _outputView.dismissOperation = ^(){
            //设置成nil，以防内存泄露
            //2_outputView = nil;
        };
        
        [_outputView pop];
        
        
    }
    else  if (textField.tag ==PinDanTargetTag)
    {
        LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"男女不限",@"只约男性",@"只约女性"] origin:CGPointMake(CGRectGetMinX(_foodPersonLBTf.frame), CGRectGetMaxY(_foodPersonLBTf.frame)) width:125 height:44 direction:kLrdOutputViewDirectionRight];
        _outputView.delegate = self;
        _outputView.tag = PinDanTargetTag;
        _outputView.dismissOperation = ^(){
            //设置成nil，以防内存泄露
            //2_outputView = nil;
        };
        
        [_outputView pop];
        
    }else
    {
        
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
#pragma mark - 用户是否可以编辑
//用户是否可以编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  NSLog(@"textField.tag---------%ld",(long)textField.tag);
//    if (textField.tag == PinDanLocationTag) {
//        
////        KCMainViewController *vc =[[KCMainViewController alloc ] init];
////        vc.delegate = self;
////        vc.navigationItem.title = @"长按选择地址";
////         vc.tabBarController.tabBar.hidden=YES;
////        [self.navigationController pushViewController:vc animated:YES];
////        _foodLocationTf.font = [UIFont systemFontOfSize:12];
//
//        return NO;
//    }
//    else  if (textField.tag ==PinDanPayTypeTag)
//    {
//        LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"我付",@"AA制"] origin:CGPointMake(CGRectGetMinX(_foodPayTypeTf.frame), CGRectGetMaxY(_foodPayTypeTf.frame)-10) width:125 height:44 direction:kLrdOutputViewDirectionRight];
//        _outputView.tag = PinDanPayTypeTag;
//        _outputView.delegate = self;
//        _outputView.dismissOperation = ^(){
//            //设置成nil，以防内存泄露
//            //2_outputView = nil;
//        };
//        
//        [_outputView pop];
//        return NO;
//        
//    }
//    else  if (textField.tag ==PinDanTargetTag)
//    {
////        LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"男女不限",@"只约男性",@"只约女性"] origin:CGPointMake(CGRectGetMinX(_foodPersonLBTf.frame), CGRectGetMaxY(_foodPersonLBTf.frame)) width:125 height:44 direction:kLrdOutputViewDirectionRight];
////        _outputView.delegate = self;
////        _outputView.tag = PinDanTargetTag;
////        _outputView.dismissOperation = ^(){
////            //设置成nil，以防内存泄露
////            //2_outputView = nil;
////        };
////        
////        [_outputView pop];
//        return NO;
//        
//    }else
//    {
//        return YES;
////    }
//    [textField resignFirstResponder];
 if (textField.tag == PinDanLocationTag)
 {
     return NO;
 }else
 {
     return YES;

 }

}

#pragma mark -  获取拼单付款方式和对象类型
-(void)LrdOutputView:(LrdOutputView *)lrdOutputView didSelectedAtIndexPath:(NSIndexPath *)indexPath currentStr:(NSString *)currentStr
{
    if (lrdOutputView.tag == PinDanPayTypeTag) {//拼单付款方式
        _foodPayTypeTf.text = currentStr;
        _foodPayTypeRow = indexPath.row;
    }else if (lrdOutputView.tag == PinDanTargetTag)//拼单对象
    {
        _foodPersonLBTf.text = currentStr;
        _foodTargetRow = indexPath.row;
    }
}

#pragma mark - KCMainViewControllerdelegate 获取地理位置
-(void)KCMainViewControllerLongProessGetLoaction:(NSString *)longPressPlacemarkStr WithLongitude:(double)mylongitude WithLatitude:(double)mylatitude
{
    [_foodLocationBtn setTitle:longPressPlacemarkStr forState:0];
    NSLog(@"----------%@",[_foodLocationBtn currentTitle]);
    
    _foodLocationTf.text = longPressPlacemarkStr;
    _loactionStr = longPressPlacemarkStr;
   _bmobGeoPoint= [[BmobGeoPoint alloc] initWithLongitude:mylongitude WithLatitude:mylatitude];
    NSLog(@"----------%f,%f",mylongitude,mylatitude);
}
#pragma mark - KMDatePickerdelegate

- (void)set_upTimePicker
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0.0, 100, rect.size.width, 216.0);
    // 年月日时分
    KMDatePicker *datePicker = [[KMDatePicker alloc]
                                initWithFrame:rect
                                delegate:self
                                datePickerStyle:KMDatePickerStyleYearMonthDayHourMinute];
    _foodTimeTf.inputView = datePicker;
     //[self.view addSubview:datePicker];
    
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
    NSString* string = [NSString stringWithFormat:@"%@%@%@%@%@00",datePickerDate.year,
                        datePickerDate.month,
                        datePickerDate.day,
                        datePickerDate.hour,
                        datePickerDate.minute];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    _bmobOrderDate = [inputFormatter dateFromString:string];
     
     
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
