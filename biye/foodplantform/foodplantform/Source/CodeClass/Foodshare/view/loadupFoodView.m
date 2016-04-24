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
    self.foodName = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 50)];
    self.foodName.placeholder = @"美食名称";
    self.foodName.textAlignment = UITextAlignmentCenter;
    [self addSubview:_foodName];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
