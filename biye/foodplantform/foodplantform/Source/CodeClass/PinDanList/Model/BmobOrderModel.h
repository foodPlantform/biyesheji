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
@property(nonatomic,strong)NSString *orderType;

//订单id
@property(nonatomic,strong)NSString *senderID;
//订单 申请的ID 及状态
@property(nonatomic,strong)NSMutableArray *applyUserAndTypeArr;
//订单 申请的人ID
@property(nonatomic,strong)NSArray *applyUserIDArr;
//订单 申请的人数 及状态 4 通过 5待审核  拼单人的状态 
@property(nonatomic,strong)NSString *applyOrderType;
//用户头像
@property(nonatomic,strong)NSString *userImgeUrl;
//订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
@property(nonatomic,strong)NSString *userOrderTyoe;

//昵称
@property(nonatomic,strong)NSString *niCheng;
@property(nonatomic,strong)NSString *sexAge;

//拼单人数
@property(nonatomic,assign)NSInteger currentPersonNum;
//拼单人数
@property(nonatomic,assign)NSInteger personMaxNum;

//拼单食物名字
@property(nonatomic,strong)NSString *name;
//拼单食物名字
@property(nonatomic,strong)NSString *foodPayType;
//拼单对象
@property(nonatomic,strong)NSString *target;
//拼单时间
@property(nonatomic,strong)NSDate *timeDate;
//拼单时间str
@property(nonatomic,strong)NSString *timeDateStr;
//拼单价格
@property(nonatomic,strong)NSString *orderPrice;
//pinLunOrderArr  评论数
@property(nonatomic,strong)NSArray *pinLunOrderArr;
//综合评价
@property(nonatomic,assign)float allPinLunStar;

//拼单地点经度

@property(nonatomic,assign)double foodLocationLatitude;
//拼单地点纬度
@property(nonatomic,assign)double foodLocationLongitude;
//拼单地点
@property(nonatomic,strong)NSString * foodLocation;

-(instancetype)initWithBomdModel :(BmobObject *)user_order;


@end
