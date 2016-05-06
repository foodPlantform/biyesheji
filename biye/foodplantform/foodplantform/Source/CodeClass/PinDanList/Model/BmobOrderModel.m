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
        self.foodPayType = [user_order objectForKey:@"order_payType"];
       
        BmobGeoPoint*bmobGeoPoint = [user_order objectForKey:@"order_loaction"];
        self.foodLocationLatitude = bmobGeoPoint.latitude;
        self.foodLocationLongitude = bmobGeoPoint.longitude;
        self.foodLocation = [user_order objectForKey:@"order_locationStr"];
        self.timeDate = [user_order objectForKey:@"order_time"];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"yyyy年MM-dd-HH:mm"];
        
        
        self.timeDateStr= [formatter stringFromDate:self.timeDate];
        
        
        
//        self. = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];

    }
    return self;
}


@end
