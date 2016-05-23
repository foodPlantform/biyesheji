//
//  chooseTimeViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "chooseTimeViewController.h"
#import "KCMainViewController.h"
#import "KMDatePickerView.h"
#import "DateHelper.h"
#import "NSDate+CalculateDay.h"
#import "KMDatePicker.h"
#import "chooseTimeView.h"

@interface chooseTimeViewController ()<KMDatePickerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)chooseTimeView *cv;
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,strong)NSString *senderID;
@end

@implementation chooseTimeViewController

-(void)loadView
{
    self.cv = [[chooseTimeView alloc]init];
    self.view = _cv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cv.sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    self.cv.time.delegate = self;
    // Do any additional setup after loading the view.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self set_upTimePicker];
}
-(void)sureAction
{
    BmobUser *user =[BmobUser getCurrentUser];
    BmobObject *user_applyList = [BmobObject objectWithClassName:@"user_apply"];
    //订单 申请的人数 及状态 5 通过 4待审核  拼单人的状态
    //订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
    
    [user_applyList setObject:@"4" forKey:@"apply_orderType"];
    [user_applyList setObject:@"2" forKey:@"sender_OrderType"];
    //0 表示order表 1 food表
    [user_applyList setObject:@"1" forKey:@"apply_type"];
    [user_applyList setObject:user.objectId forKey:@"apply_userID"];
    [user_applyList setObject:user.username forKey:@"apply_userName"];
    [user_applyList setObject:self.foodID forKey:@"order_ID"];
    NSLog(@"phone%@",_fm.phone);
    BmobQuery *query = [BmobQuery queryWithClassName:@"_User"];
    [query whereKey:@"mobilePhoneNumber" equalTo:_fm.phone];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        BmobObject *obj = array[0];
        [user_applyList setObject:[obj objectForKey:@"objectId"] forKey:@"sender_userID"];
        
        [user_applyList setObject:[obj objectForKey:@"username"] forKey:@"sender_userName"];
        self.senderID = [obj objectForKey:@"objectId"];
        
        [user_applyList saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [[regAndLogTool shareTools] messageShowWith:@"预订成功" cancelStr:@"确定"];
                BmobQuery *userquery = [BmobQuery queryForUser];
                [userquery whereKey:@"objectId" equalTo:_senderID];
                
                [userquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    
                    BmobObject *obj = array[0];
                    BmobPush *push = [BmobPush push];
                    BmobQuery *query = [BmobInstallation query];
                    [query whereKey:@"deviceToken" equalTo:[obj objectForKey:@"deviceToken"]];
                    [push setQuery:query];
                    [push setMessage:@"有人申请你的订单了，去看看吧"];
                    [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                        NSLog(@"error %@",[error description]);
                    }];
                }];
                
            }
        }];
        
        
    }];

    [[regAndLogTool shareTools] messageShowWith:@"预订成功" cancelStr:@"确定"];
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
    self.cv.time.inputView = datePicker;
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
    _date = [inputFormatter dateFromString:string];
    
    
    self.cv.time.font = [UIFont systemFontOfSize:12];
    
    self.cv.time.text = dateStr;
    
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
