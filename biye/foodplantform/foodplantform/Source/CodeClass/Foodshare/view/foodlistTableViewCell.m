//
//  foodlistTableViewCell.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/20.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "foodlistTableViewCell.h"

@implementation foodlistTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self p_setView];
    }
    return self;
}

-(void)p_setView
{
    self.foodPic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 100)];
    [self.contentView addSubview:_foodPic];
    self.foodName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.foodPic.frame)+10, 5, kScreenWidth - 150, 33)];

    [self.contentView addSubview:_foodName];
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.foodName.frame),CGRectGetMaxY(self.foodName.frame), CGRectGetWidth(self.foodName.frame), 33)];
    [self.contentView addSubview:_addressLabel];
    self.starLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.addressLabel.frame), CGRectGetMaxY(self.addressLabel.frame), 100, 33)];
    self.starLabel.text  = @"综合星级";
    [self.contentView addSubview:_starLabel];
    self.starScore = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starLabel.frame), CGRectGetMaxY(self.addressLabel.frame), 100, 33)];
    self.starScore.maximumValue = 5;
    self.starScore.minimumValue = 0;
    self.starScore.tintColor = [UIColor redColor];
    self.starScore.enabled = NO;
    self.starScore.allowsHalfStars = YES;
    [self.contentView addSubview:_starScore];
    self.userStarLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.starLabel.frame), CGRectGetMaxY(self.starScore.frame), 100, 33)];
    self.userStarLabel.text  =  @"用户星级";
    [self.contentView addSubview:_userStarLabel];
    self.userStar = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userStarLabel.frame), CGRectGetMinY(self.userStarLabel.frame), 100, 33)];
    self.userStar.maximumValue = 5;
    self.userStar.minimumValue = 0;
    self.userStar.tintColor = [UIColor blueColor];
    self.userStar.enabled = NO;
    self.userStar.allowsHalfStars = YES;
    [self.contentView addSubview:_userStar];
    self.sty = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starScore.frame)+10, CGRectGetMinY(self.starScore.frame), kScreenWidth -CGRectGetWidth(self.starScore.frame), CGRectGetHeight(self.starScore.frame))];
    [self.contentView addSubview:_sty];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
