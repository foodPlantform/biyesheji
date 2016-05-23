//
//  orderView.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "orderView.h"

@implementation orderView
-(instancetype)init
{
    if (self = [super init]) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 170)];
    [self addSubview:_scrollView];
    self.foodName = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 50)];
    self.foodName.textAlignment = UITextAlignmentCenter;
    //self.foodName.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:_foodName];
    self.fooddes = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.foodName.frame), kScreenWidth, 100)];
    //self.fooddes.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:_fooddes];
    self.rec = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.fooddes.frame), CGRectGetMaxY(self.fooddes.frame)+5, 100, 50)];
    self.rec.textAlignment = UITextAlignmentCenter;
    //self.rec.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:_rec];
    self.sty = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.rec.frame), CGRectGetMaxY(self.rec.frame), 100, 50)];
    self.sty.textAlignment = UITextAlignmentCenter;
    //self.sty.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:_sty];
    self.add = [UIButton buttonWithType:UIButtonTypeSystem];
    self.add.frame = CGRectMake(kScreenWidth - 160, CGRectGetMinY(self.rec.frame), 50, 50);
    //[self.add setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.add setTitle:@"加+" forState:UIControlStateNormal];
    [self.scrollView addSubview:_add];
    self.count = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.add.frame), CGRectGetMinY(self.add.frame), 50, 50)];
    self.count.textAlignment = UITextAlignmentCenter;
    [self.scrollView addSubview:_count];
    self.sub = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sub.frame = CGRectMake(CGRectGetMaxX(self.count.frame), CGRectGetMinY(self.count.frame), 50, 50);
    //[self.sub setBackgroundImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
    [self.sub setTitle:@"-减" forState:UIControlStateNormal];
    [self.scrollView addSubview:_sub];
    self.resultName = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sty.frame)+20, 100, 50)];
    //self.resultName.backgroundColor  = [UIColor grayColor];
    [self.scrollView addSubview:_resultName];
    self.resultNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.resultName.frame), CGRectGetMinY(self.resultName.frame), 50, 50)];
    //self.resultNum.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:_resultNum];
    self.sure = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sure.frame = CGRectMake(kScreenWidth - 100,CGRectGetMinY(self.resultName. frame), 100, 50);
    [self.sure setTitle:@"确定" forState:UIControlStateNormal];
    [self.scrollView addSubview:_sure];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.sure.frame)+30);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
