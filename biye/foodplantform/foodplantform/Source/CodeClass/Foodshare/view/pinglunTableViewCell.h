//
//  pinglunTableViewCell.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
@interface pinglunTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)HCSStarRatingView *star;
@end
