//
//  BmobOrderModel.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/4.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BmobOrderModel : NSObject

//订单id
@property(nonatomic,strong)NSString *orderID;

//用户头像
@property(nonatomic,strong)NSString *imgeUrl;
//昵称
@property(nonatomic,strong)NSString *niCheng;
@property(nonatomic,strong)NSString *sexAge;

//拼单人数
@property(nonatomic,strong)NSString *currentPersonNum;
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
-(instancetype)initWithBomdModel :(BmobObject *)user_order;


@end
