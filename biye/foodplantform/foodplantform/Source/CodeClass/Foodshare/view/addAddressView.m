//
//  addAddressView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "addAddressView.h"

@implementation addAddressView
-(instancetype)init
{
    if (self == [super init]) {
        [self p_setView];
    }
    return self;
}

-(void)p_setView
{
    self.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self addSubview:_scrollView];
    self.chooseCity = [UIButton buttonWithType:UIButtonTypeSystem];
    self.chooseCity.frame = CGRectMake(10, 20, 100, 50);
    [self.chooseCity setTitle:@"选择城市" forState:UIControlStateNormal];
    [self.scrollView addSubview:_chooseCity];
    self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.chooseCity.frame)+10, CGRectGetMinY(self.chooseCity.frame), 100, 50)];
    [self.scrollView addSubview:_cityLabel];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.chooseCity.frame)+10, 100, 50)];
    self.nameLabel.text = @"姓名:";
    [self.scrollView addSubview:_nameLabel];
    self.name = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), CGRectGetMinY(self.nameLabel.frame), 200, 50)];
    self.name.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_name];
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame)+10, 100, 50)];
    self.phoneLabel.text = @"电话:";
    [self.scrollView addSubview:_phoneLabel];
    self.phone = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneLabel.frame), CGRectGetMinY(self.phoneLabel.frame), 200, 50)];
    self.phone.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_phone];
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneLabel.frame), CGRectGetMaxY(self.phoneLabel.frame)+10, 100, 50)];
    self.addressLabel.text  = @"地址:";
    [self.scrollView addSubview:_addressLabel];
    self.address = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressLabel.frame), CGRectGetMinY(self.addressLabel.frame), 200, 50)];
    self.address.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_address];
    self.sure = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sure.frame = CGRectMake(0, CGRectGetMaxY(self.address.frame)+10, kScreenWidth, 50);
    [self.sure setTitle:@"确定" forState:UIControlStateNormal];
    [self.scrollView addSubview:_sure];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
