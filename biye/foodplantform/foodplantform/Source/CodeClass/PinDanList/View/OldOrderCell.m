//
//  OldOrderCell.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/19.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "OldOrderCell.h"

@implementation OldOrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupOldOrderCellView];
    }
    return self;
}
- (void)setupOldOrderCellView
{
    _pinlunUserNameLB = [[UILabel alloc] init];
    _pinlunUserNameLB.frame =  CGRectMake(0, 10, kScreenWidth, 30);
    _pinlunUserNameLB.text = @"评论人 ：评论信息"  ;
    [self.contentView addSubview:_pinlunUserNameLB];
//    _pinlunContentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_pinlunUserNameLB.frame), CGRectGetMaxY(_pinlunUserNameLB.frame)+5, kScreenWidth, 20)];
//    _pinlunContentLB.text = @"评论信息：评论信息"  ;
//    [self.contentView addSubview:_pinlunContentLB];
    _pinLunStarView = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_pinlunUserNameLB.frame), CGRectGetMaxY(_pinlunUserNameLB.frame)+5, 100,  20)];
    _pinLunStarView.maximumValue = 5;
   _pinLunStarView.minimumValue = 0;
    _pinLunStarView.allowsHalfStars = YES;
    _pinLunStarView.value = 1.2;
    _pinLunStarView.tintColor = [UIColor redColor];
   _pinLunStarView.enabled = NO;
    
    
    [self.contentView addSubview:_pinLunStarView];
    //NSLog(@"---------------%f", CGRectGetMaxY(_pinLunStarView.frame));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
