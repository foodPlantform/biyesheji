//
//  UserApplyListModel.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/11.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "BmobOrderModel.h"

@interface UserApplyListModel : BmobOrderModel
@property(nonatomic,strong)NSString *applyListobjectId;
//订单 申请的人ID
@property(nonatomic,strong)NSString *applyUserListID;
@property(nonatomic,strong)NSString *applyUserListName;
//订单 申请的人数 及状态 5 通过 4待审核  拼单人的状态
@property(nonatomic,strong)NSString *applyOrderListType;
//发单人ID
@property(nonatomic,strong)NSString *senderUserIListD;
@property(nonatomic,strong)NSString *senderUserListName;
//订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
@property(nonatomic,strong)NSString *senderOrderListType;
@property(nonatomic,strong)NSString *orderListID;
-(instancetype)initWithBomdModel :(BmobObject *)UserApply;
@end
