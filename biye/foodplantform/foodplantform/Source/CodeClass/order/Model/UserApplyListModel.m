//
//  UserApplyListModel.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/11.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "UserApplyListModel.h"

@implementation UserApplyListModel
/*
 //加到applyOrder表中 便于管理
 BmobObject  *user_applyList = [BmobObject objectWithClassName:@"user_apply"];
 [user_applyList setObject:@"5" forKey:@"apply_orderType"];
 [user_applyList setObject:@"2" forKey:@"sender_OrderType"];
 [user_applyList setObject:bUser.objectId forKey:@"apply_userID"];
 [user_applyList setObject:model.senderID forKey:@"sender_userID"];
 
 [user_applyList setObject:model.orderID forKey:@"order_ID"];
 */
-(instancetype)initWithUserApplyListBomdModel :(BmobObject *)UserApply
{
    self = [super init];
    if (self)
    {
        self.applyListobjectId = [UserApply objectForKey:@"objectId"];

        self.applyOrderListType = [UserApply objectForKey:@"apply_orderType"];
        self.senderOrderListType = [UserApply objectForKey:@"sender_OrderType"];
        self.applyUserListID = [UserApply objectForKey:@"apply_userID"] ;
        self.applyUserListName = [UserApply objectForKey:@"apply_userName"] ;
        self.senderUserListName = [UserApply objectForKey:@"sender_userName"] ;
        self.senderUserIListD = [UserApply objectForKey:@"sender_userID"];
        self.orderListID = [UserApply objectForKey:@"order_ID"];
        self. applyList_type = [UserApply objectForKey:@"apply_type"];
        
    }
    return self;
}
@end
