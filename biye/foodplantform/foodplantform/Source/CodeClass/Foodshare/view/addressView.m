//
//  addressView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "addressView.h"

@implementation addressView
-(instancetype)init
{
    if (self == [super init]) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-170)];
    [self addSubview:_tableView];
    self.btn = [UIButton buttonWithType: UIButtonTypeSystem];
    self.btn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, 50);
    self.btn.backgroundColor = [UIColor blueColor];
    [self.btn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:_btn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
