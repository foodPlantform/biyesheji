//
//  personTableViewCell.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "personTableViewCell.h"

@implementation personTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3.0, 10, kScreenWidth/3.0, kScreenWidth/3.0)];
        self.picture.layer.cornerRadius = 50;
        self.picture.layer.masksToBounds = YES;
        [self.contentView addSubview:_picture];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
