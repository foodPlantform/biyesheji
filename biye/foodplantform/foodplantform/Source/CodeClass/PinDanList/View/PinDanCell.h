//
//  PinDanCell.h
//  foodplantform
//
//  Created by 仇亚利 on 16/4/22.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinDanCell : UITableViewCell

//用户头像
@property(nonatomic,strong)UIImageView *userImgV;
//昵称
@property(nonatomic,strong)UILabel *userNiChengLB;
@property(nonatomic,strong)UILabel *userSexAgeLB;

//拼单人数
@property(nonatomic,strong)UILabel *foodPersonNumLB;
//拼单食物名字
@property(nonatomic,strong)UILabel *foodNameLB;
//拼单对象
@property(nonatomic,strong)UILabel *foodPersonLB;
//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;
//加入拼单

@property(nonatomic,strong)UIButton *addPindanBtn;

@end
