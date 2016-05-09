//
//  OrderCell.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BmobOrderModel.h"
@interface OrderCell : UITableViewCell
//拼单名称
@property(nonatomic,strong)UILabel *foodNameLB;
//拼单处理事件
@property(nonatomic,strong)UIButton *orderBtn;
//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;
//拼单人数
@property(nonatomic,strong)UILabel *foodNumLB;
@property(nonatomic,strong)BmobOrderModel *model;
@property(nonatomic,strong)NSString *vcOrderType;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
