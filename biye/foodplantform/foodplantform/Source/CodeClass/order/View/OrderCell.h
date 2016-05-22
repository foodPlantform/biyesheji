//
//  OrderCell.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodListModel;
@class OrderCell;
@class BmobOrderModel;
@class UserApplyListModel;
@protocol OrderCelllDelegate <NSObject>

/**
 *  按钮点击加入拼单
 *
 *  @param index <#index description#>
 */
@optional
#pragma mark -  order表的处理方法
- (void)handleOrderCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel;
- (void)ChatOrderCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel;
//显示评论
- (void)showPinlunCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel;
//加好友
- (void)AddFriendPinlunCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel;

#pragma mark -  美食表的处理方法
// 评论 同意 已完成
- (void)handleFoodCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(FoodListModel *)handeledModel;
- (void)noAgreeFoodCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(FoodListModel *)handeledModel;
@end
#import "BmobOrderModel.h"
#import "UserApplyListModel.h"
#import "FoodListModel.h"
@interface OrderCell : UITableViewCell
@property (strong, nonatomic) id<OrderCelllDelegate>delegate;

//拼单名称
@property(nonatomic,strong)UILabel *foodNameLB;
//拼单加入人 或者是发单人
@property(nonatomic,strong)UILabel *foodUserNameLB;
@property(nonatomic,strong)UIButton *foodUserNameBtn;

//拼单处理事件
@property(nonatomic,strong)UIButton *orderBtn;
//拼单聊天事件
@property(nonatomic,strong)UIButton *orderChatBtn;
//拼单聊天事件
@property(nonatomic,strong)UIButton * addFriendBtn;
//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;
//拼单人数
@property(nonatomic,strong)UILabel *foodNumLB;
//已完成的订单  apply表里面的订单

@property(nonatomic,strong)UserApplyListModel *model;

//已完成的订单  apply表里面的订单
@property(nonatomic,strong)FoodListModel *foodListModel;

@property(nonatomic,strong)NSString *vcOrderType;
@property(nonatomic,strong)NSString *vcOrderOrFoodType;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
