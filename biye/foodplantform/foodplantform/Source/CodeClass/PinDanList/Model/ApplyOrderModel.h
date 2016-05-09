//
//  ApplyOrderModel.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyOrderModel : NSObject
//用户ID
@property(nonatomic,strong)NSString *userID;
//订单状态
@property(nonatomic,strong)NSString *orderType;

-(instancetype)initWithBomdModel :(id )order_apply;

@end
