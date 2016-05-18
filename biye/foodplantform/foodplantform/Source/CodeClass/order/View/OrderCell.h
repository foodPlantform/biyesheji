//
//  OrderCell.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
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

- (void)handleOrderCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel;

@end
#import "BmobOrderModel.h"
#import "UserApplyListModel.h"
@interface OrderCell : UITableViewCell
@property (strong, nonatomic) id<OrderCelllDelegate>delegate;

//拼单名称
@property(nonatomic,strong)UILabel *foodNameLB;
//拼单加入人 或者是发单人
@property(nonatomic,strong)UILabel *foodUserNameLB;

//拼单处理事件
@property(nonatomic,strong)UIButton *orderBtn;
//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;
//拼单人数
@property(nonatomic,strong)UILabel *foodNumLB;
@property(nonatomic,strong)UserApplyListModel *model;

//已完成的订单  apply表里面的订单
@property(nonatomic,strong)UserApplyListModel *applyedModel;
@property(nonatomic,strong)NSString *vcOrderType;
@property(nonatomic,strong)NSString *vcOrderOrFoodType;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
