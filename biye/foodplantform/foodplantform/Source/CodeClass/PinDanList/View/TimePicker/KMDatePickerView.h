//
//  KMDatePickerView.h
//  CarSu
//
//  Created by 寇敏 on 16/5/4.
//  Copyright © 2016年 LongShine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMDatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property(retain,nonatomic)UIView *botomView;
@property(retain,nonatomic)UIButton *bgButton;
@property(nonatomic,copy)void  (^SelectDateBlock)(NSString *);
@property (retain, nonatomic) NSMutableArray *titles;
+(KMDatePickerView *)shareView;
+(void)show;
-(void)dismiss;
@end
