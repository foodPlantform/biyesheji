//
//  myFoodTableViewCell.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/15.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "myFoodTableViewCell.h"

@implementation myFoodTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setView];
    }
    return self;
}
-(void)p_setView
{
    self.backgroundColor = [UIColor whiteColor];
    self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 100, 90)];
    [self.contentView addSubview:_pic];
    self.foodName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pic.frame), CGRectGetMinY(self.pic.frame)+30, kScreenWidth - 110, 50)];
    [self.contentView addSubview:_foodName];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
