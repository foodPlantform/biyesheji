//
//  BmobOrderModel.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/4.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "BmobOrderModel.h"

@implementation BmobOrderModel
-(instancetype)initWithBomdModel :(BmobObject *)user_order
{
    self = [super init];
    if (self) {
        
        /*
         //用户头像
         @property(nonatomic,strong)NSString *imgeUrl;
         //昵称
         @property(nonatomic,strong)NSString *niCheng;
         @property(nonatomic,strong)NSString *sexAge;
         
         //拼单人数
         @property(nonatomic,strong)NSString *personNum;
         //拼单人数
         @property(nonatomic,strong)NSString *personMaxNum;
         
         //拼单食物名字
         @property(nonatomic,strong)NSString *name;
         //拼单对象
         @property(nonatomic,strong)NSString *target;
         //拼单时间
         @property(nonatomic,strong)NSDate *time;
         //拼单地点
         @property(nonatomic,strong)NSString *foodLocation;
         */
        self.orderID = [user_order objectForKey:@"objectId"];
        self.personMaxNum = [user_order objectForKey:@"order_maxnum"];
        self.currentPersonNum = [user_order objectForKey:@"order_num"];
        self.name = [user_order objectForKey:@"order_name"];
        self.target = [user_order objectForKey:@"order_target"];
        self.time = [user_order objectForKey:@"createdAt"];
//        self. = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];

    }
    return self;
}


@end
