//
//  OldOrderCell.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/19.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface OldOrderCell : UITableViewCell
//用户人 + 评论内容
@property(nonatomic,strong)UILabel *pinlunUserNameLB;
//用户人 + 评论内容
@property(nonatomic,strong)UILabel *pinlunContentLB;
//评论星级
@property(nonatomic,strong)HCSStarRatingView *pinLunStarView;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;

@end
