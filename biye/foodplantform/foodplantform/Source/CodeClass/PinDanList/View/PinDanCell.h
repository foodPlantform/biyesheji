//
//  PinDanCell.h
//  foodplantform
//
//  Created by 仇亚利 on 16/4/22.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BmobOrderModel;
@class PinDanCell;
@protocol PindanCelllDelegate <NSObject>

/**
 *  按钮点击加入拼单
 *
 *  @param index <#index description#>
 */
@optional

- (void)addOrderPinDanCell:(PinDanCell *)cell model:(BmobOrderModel *)model;
- (void)showOldOrderPinDanCell:(PinDanCell *)cell model:(BmobOrderModel *)model;
- (void)addSenderFriendOrderPinDanCell:(PinDanCell *)cell model:(BmobOrderModel *)model;

@end
#import <CoreLocation/CoreLocation.h>

#import "BmobOrderModel.h"
@interface PinDanCell : UITableViewCell
@property (strong, nonatomic) id<PindanCelllDelegate>delegate;

//用户头像
@property(nonatomic,strong)UIImageView *userImgV;
//昵称
@property(nonatomic,strong)UILabel *userNiChengLB;
//名称btn
@property(nonatomic,strong)UIButton *userNiChengBtn;
//加好友
@property(nonatomic,strong)UIButton *addSenderFriendBtn;
@property(nonatomic,strong)UILabel *userSexAgeLB;

//拼单人数
@property(nonatomic,strong)UILabel *foodPersonNumLB;
//拼单食物名字
@property(nonatomic,strong)UILabel *foodNameLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodPayTypeLB;
//拼单对象
@property(nonatomic,strong)UILabel *foodPersonLB;
//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;

//拼单地点  距离地点
@property(nonatomic,strong)UILabel *foodKMLB;
// 当前位置
@property(nonatomic,strong)CLLocation *currentLocation;
//加入拼单

@property(nonatomic,strong)UIButton *addPindanBtn;
@property(nonatomic,strong)BmobOrderModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
@end
