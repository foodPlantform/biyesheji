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
