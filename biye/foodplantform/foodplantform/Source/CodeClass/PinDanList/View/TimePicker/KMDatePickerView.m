//
//  KMDatePickerView.m
//  CarSu
//
//  Created by 寇敏 on 16/5/4.
//  Copyright © 2016年 LongShine. All rights reserved.
//

#import "Masonry.h"
#import "KMDatePickerView.h"
#define CHOOSE_DAY_COUNT 7
#define kWindowHeight [[UIScreen mainScreen] bounds].size.height
#define kWindowWidth [[UIScreen mainScreen] bounds].size.width

@implementation KMDatePickerView
{
    UIPickerView *_pickView ;
    NSString *_selectDate;
    NSInteger *_currentRow;
    NSMutableArray *_lastArray;
    NSMutableArray *_dataArray;
    NSMutableArray *_selectArray;
}

+(KMDatePickerView*)shareView
{
    
    static dispatch_once_t once;
    static KMDatePickerView *date;
    
    dispatch_once(&once, ^{
       
        date = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        
    });
    
    
    return date;
    
}


-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        //半透明背景按钮
        _bgButton = [[UIButton alloc] init];
        [self addSubview:_bgButton];
        //[_bgButton addTarget:self action:@selector(dismissDatePicker) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.backgroundColor = [UIColor blackColor];
        _bgButton.alpha = 0;
        _bgButton.frame = CGRectMake(0, 0, kWindowWidth, kWindowHeight);
        
        
        
        _botomView = [[UIView alloc]init];
        _botomView.frame = CGRectMake(0, kWindowHeight, kWindowWidth, 200);
        _botomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_botomView];
        
        
        
        UIButton * cancelBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cancelBt addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchDown];
        [_botomView addSubview:cancelBt];
        [cancelBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_botomView.mas_top);
            make.left.equalTo(_botomView.mas_left).offset(20);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(50);
            
        }];
        
        UIButton * confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBt setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBt addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchDown];
        [confirmBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_botomView addSubview:confirmBt];
        [confirmBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_botomView.mas_top);
            make.right.equalTo(_botomView.mas_right).offset(-20);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(50);
            
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.frame = CGRectMake(0, 41, kWindowWidth, 1);
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.1;
        [_botomView addSubview:line];
        
        
        
        _pickView = [[UIPickerView alloc]init];
        _pickView .dataSource =self;
        _pickView .delegate = self;
        [_botomView addSubview:_pickView ];
        [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(confirmBt.mas_bottom);
            make.left.equalTo(_botomView.mas_left);
            make.right.equalTo(_botomView.mas_right);
            make.bottom.equalTo(_botomView.mas_bottom);
            
        }];

        NSString *_minDay = @"1";
        NSString *_maxDay = @"10";
        
//        for (NSDictionary *dic in [SystemCode shareCode].codeData) {
//            
//            
//            if ([dic[@"paramCode"] isEqualToString:@"minRentDay"]) {
//                
//                _minDay = dic[@"paramValue"];
//            }
//            
//            if ([dic[@"paramCode"] isEqualToString:@"maxRentDay"]) {
//                
//                _maxDay = dic[@"paramValue"];
//            }
//            
//            
//        }

        
       
        _dataArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i = [_minDay intValue]; i <[_minDay floatValue]+[_maxDay intValue]; i++) {
           
            NSDate *date = [NSDate dateWithTimeInterval:24*60*60*i sinceDate:[NSDate date]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateStr = [formatter stringFromDate:date];
            NSArray *time = [dateStr componentsSeparatedByString:@" "];
            
            
            
            if (i==[_minDay intValue]) {
               
                dateStr =[NSString stringWithFormat:@"明天 %@",time[1]];
                
            }
            
            if (i==[_minDay intValue]+1) {
                
                dateStr =[NSString stringWithFormat:@"后天 %@",time[1]];
            }
            
            
            
            [_dataArray addObject:dateStr];
            
           
            
        }

        
        
        _selectArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i = [_minDay intValue]; i <[_minDay floatValue]+[_maxDay intValue]; i++) {
            
            NSDate *date = [NSDate dateWithTimeInterval:24*60*60*i sinceDate:[NSDate date]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateStr = [formatter stringFromDate:date];
            
            [_selectArray addObject:dateStr];
            
            
        }


        NSLog(@"%@",_selectArray);
        
        
        
        
        
    }
    
    return self;
    
}

+(void)show
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:[self shareView]];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self shareView].bgButton.alpha = 0.3;
        [self shareView].botomView.frame = CGRectMake(0, kWindowHeight-200, kWindowWidth, 200);
        
    } completion:^(BOOL finished) {
        
                
        
    }];
    
    
    
    
}


- (void)setTitles:(NSMutableArray *)titles
{
    _titles = titles;
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _selectDate = _selectArray[row];
    
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataArray[row];
}

-(void)confirmClick:(UIButton*)but
{
    
    if (self.SelectDateBlock) {
        
        if (_selectDate==nil) {
            
            _selectDate = _selectArray[0];
            self.SelectDateBlock(_selectDate);
            [self dismiss];
            
            
        }
        else{
            
            
            self.SelectDateBlock(_selectDate);
            [self dismiss];
            
        }
    }
    
    
    
    
    
}

-(void)cancelClick
{
    
    [self dismiss];
    
    
}



-(void)dismiss
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _botomView.frame = CGRectMake(0, kWindowHeight, kWindowWidth, 200);
        
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
        
    }];
    
    
    
}



@end
