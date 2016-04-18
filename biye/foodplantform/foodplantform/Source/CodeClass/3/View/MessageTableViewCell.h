//
//  MessageTableViewCell.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headImage;//头像图片
@property(nonatomic,strong)UILabel * toUserNickName;//聊天对象的昵称或者群名称
@property(nonatomic,strong)UILabel * text;//聊天内容（一行）

@end
