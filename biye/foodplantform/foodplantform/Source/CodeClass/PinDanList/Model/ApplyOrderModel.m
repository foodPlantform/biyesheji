//
//  ApplyOrderModel.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "ApplyOrderModel.h"

@implementation ApplyOrderModel
-(instancetype)initWithBomdModel :(NSDictionary *)order_apply
{
    self =  [super init];
    if (self)
    {
        self.userID = [order_apply objectForKey:@"userID"];
        self.orderType = [order_apply objectForKey:@"userOrderType"];
    }
    return self;
}
@end
