//
//  foodlistTableViewCell.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/20.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
@interface foodlistTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *foodPic;

@property(nonatomic,strong)UILabel *foodName;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *starLabel;
@property(nonatomic,strong)UILabel *userStarLabel;
@property(nonatomic,strong)HCSStarRatingView *starScore;
@property(nonatomic,strong)HCSStarRatingView *userStar;
@property(nonatomic,strong)UILabel *sty;
@end
