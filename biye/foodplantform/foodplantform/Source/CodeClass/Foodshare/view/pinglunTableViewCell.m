//
//  pinglunTableViewCell.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "pinglunTableViewCell.h"

@implementation pinglunTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView
{
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 10)];
    self.name.text = @"用户:";
    [self.contentView addSubview:_name];
    self.userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame), CGRectGetMinY(self.name.frame), kScreenWidth-50, 10)];
    [self.contentView addSubview:_userName];
    self.star = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame)+5, 100, 20)];
    self.star.maximumValue = 5;
    self.star.minimumValue = 0;
    self.star.tintColor = [UIColor redColor];
    self.star.enabled = NO;

    
    [self.contentView addSubview:_star];
    self.content  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.star.frame), kScreenWidth - 10, 30)];
    [self.contentView addSubview:_content];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
