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
    self.foodPic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
    [self.contentView addSubview:_foodPic];
    self.foodName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.foodPic.frame)+10, 5, kScreenWidth - 100, 45)];
    [self.contentView addSubview:_foodName];
    self.starScore = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.foodName.frame), CGRectGetMaxY(self.foodName.frame), 100, 45)];
    self.starScore.maximumValue = 5;
    self.starScore.minimumValue = 0;
    self.starScore.tintColor = [UIColor redColor];
    self.starScore.enabled = NO;
    [self.contentView addSubview:_starScore];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
