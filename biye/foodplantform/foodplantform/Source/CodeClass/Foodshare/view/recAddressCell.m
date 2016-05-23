//
//  recAddressCell.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "recAddressCell.h"

@implementation recAddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setView];
    }
    return self;
}

-(void)p_setView
{
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 50)];
    self.name.numberOfLines = 0;
    [self.contentView addSubview:_name];
    self.phone = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.name.frame)+10, CGRectGetMinY(self.name.frame), 200, 50)];
    self.phone.numberOfLines = 0;
    [self.contentView addSubview:_phone];
    self.address = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.phone.frame)+10, kScreenWidth, 50)];
    self.address.numberOfLines = 0;
    [self.contentView addSubview:_address];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
