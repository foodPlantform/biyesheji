//
//  BmobOrderModel.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/4.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "BmobOrderModel.h"
#import "ApplyOrderModel.h"
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
        
        self.userImgeUrl = [user_order objectForKey:@"user_headUrl"];
        self.orderID = [user_order objectForKey:@"objectId"];
        self.personMaxNum = [[user_order objectForKey:@"order_maxNum"] integerValue];
        self.currentPersonNum = [[user_order objectForKey:@"order_currentNum"] integerValue];
        self.name = [user_order objectForKey:@"order_name"];
        self.niCheng = [user_order objectForKey:@"order_userName"];
        self.orderPrice = [user_order objectForKey:@"order_Price"];
        self.orderType = [user_order objectForKey:@"order_Type"];
        self.target = [user_order objectForKey:@"order_target"];
        self.applyUserAndTypeArr = [[NSMutableArray alloc] initWithCapacity:0];
//        NSArray *applyArr = [user_order objectForKey:@"apply_userArr"];
//        for (NSDictionary *dic in  applyArr )
//        {
//            ApplyOrderModel *applyModel =  [[ApplyOrderModel alloc] initWithBomdModel:dic];
//            
//            [self.applyUserAndTypeArr addObject:applyModel];
//        }
        self.userOrderTyoe = [user_order objectForKey:@"user_orderType"];
        self.applyUserIDArr = [user_order objectForKey:@"apply_userIDArr"];
       self.foodPayType = [user_order objectForKey:@"order_payType"];
       self.senderID = [user_order objectForKey:@"order_senderID"];
        
        BmobGeoPoint*bmobGeoPoint = [user_order objectForKey:@"order_loaction"];
        self.foodLocationLatitude = bmobGeoPoint.latitude;
        self.foodLocationLongitude = bmobGeoPoint.longitude;
        self.foodLocation = [user_order objectForKey:@"order_locationStr"];
        self.timeDate = [user_order objectForKey:@"order_time"];
        self.applyOrderType = [user_order objectForKey:@"apply_orderType"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"yyyy年MM月dd日HH:mm"];
        //593322
        
        self.timeDateStr= [formatter stringFromDate:self.timeDate];
        
        
        
//        self. = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];
//        self.orderID = [user_order objectForKey:@"objectId"];

    }
    return self;
}


@end
