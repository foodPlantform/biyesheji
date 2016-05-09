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
    self.starScore = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.addressLabel.frame), CGRectGetMaxY(self.addressLabel.frame), 100, 33)];
    self.starScore.maximumValue = 5;
    self.starScore.minimumValue = 0;
    self.starScore.tintColor = [UIColor redColor];
    self.starScore.enabled = NO;
    [self.contentView addSubview:_starScore];
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
