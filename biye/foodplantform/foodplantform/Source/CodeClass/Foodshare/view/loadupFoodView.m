//
//  loadupFoodView.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "loadupFoodView.h"

@implementation loadupFoodView
-(instancetype)init
{
    if (self = [super init]) {
    
        [self p_setView];
    }
    return self;
}

-(void)p_setView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight)];
    [self addSubview:_scrollView];
    self.backgroundColor = [UIColor whiteColor];
    self.chooseCity = [UIButton buttonWithType:UIButtonTypeSystem];
    self.chooseCity.frame = CGRectMake(10, 30, 100, 30);
    [self.chooseCity setTitle:@"选择城市" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:_chooseCity];
    self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.chooseCity.frame), CGRectGetMinY(self.chooseCity.frame), kScreenWidth - CGRectGetWidth(self.chooseCity.frame), CGRectGetHeight(self.chooseCity.frame))];
    [self.scrollView addSubview:_cityLabel];
    
    // 美食名称
    self.foodName = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 50)];
    self.foodName.placeholder = @"美食名称";
    self.foodName.textAlignment = UITextAlignmentCenter;
    [_scrollView addSubview:_foodName];
    
    // 美食描述
    self.foodDes = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.foodName.frame)+10, kScreenWidth, 100)];
    self.foodDes.placeholder = @"美食描述";
    self.foodDes.textAlignment = UITextAlignmentCenter;
    [_scrollView addSubview:_foodDes];
    
    // 详细地址
    self.address = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.foodDes.frame)+10, kScreenWidth, 50)];
    self.address.placeholder = @"详细地址";
    self.address.textAlignment = UITextAlignmentCenter;
    [_scrollView addSubview:_address];
    
    // 各种BUtton
    self.imgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.imgBtn.frame = CGRectMake(0, CGRectGetMaxY(self.address.frame)+10, kScreenWidth/3.0, 30);
    [self.imgBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [_scrollView addSubview:_imgBtn];
    
    self.chooseRec = [UIButton buttonWithType:UIButtonTypeSystem];
    self.chooseRec.frame = CGRectMake(CGRectGetMaxX(self.imgBtn.frame), CGRectGetMinY(self.imgBtn.frame), kScreenWidth/3.0, 30);
    [self.chooseRec setTitle:@"是否预订" forState:UIControlStateNormal];
    [_scrollView addSubview:_chooseRec];
    
    
    self.chooseSty = [UIButton buttonWithType:UIButtonTypeSystem];
    self.chooseSty.frame = CGRectMake(CGRectGetMaxX(self.chooseRec.frame), CGRectGetMinY(self.imgBtn.frame), kScreenWidth/3.0, 30);
    [self.chooseSty setTitle:@"选择类型" forState:UIControlStateNormal];
    [_scrollView addSubview:_chooseSty];
    
    // 结果
    
    self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgBtn.frame)+10, 100, 100)];
    [_scrollView addSubview:_picture];
    
    self.rec = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picture.frame)+10, CGRectGetMinY(self.picture.frame), kScreenWidth-110, 50)];
    [_scrollView addSubview:_rec];
    
    self.sty = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.rec.frame), CGRectGetMaxY(self.rec.frame), CGRectGetWidth(self.rec.frame), 50)];
    [_scrollView addSubview:_sty];
    
    // 提交按钮
    self.upBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.upBtn.frame = CGRectMake(0, CGRectGetMaxY(self.picture.frame)+20, kScreenWidth, 50);
    [self.upBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_scrollView addSubview:_upBtn];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.upBtn.frame)+50);


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
