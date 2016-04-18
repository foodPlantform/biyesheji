//
//  MessageTableViewCell.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell


//自定义Cell的初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView{
    //cell上的头像
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
    self.headImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_headImage];
    //设置圆角，头像看起来更圆滑
    self.headImage.layer.cornerRadius = 5;
    
    //cell上的昵称
    self.toUserNickName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame)+10, CGRectGetMinY(self.headImage.frame), 300, CGRectGetHeight(_headImage.frame) / 2)];
    self.toUserNickName.text = @"聊天人昵称（测试）";
    [self.contentView addSubview:_toUserNickName];
    
    
    //cell的聊天内容
    self.text = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_toUserNickName.frame), CGRectGetMaxY(_toUserNickName.frame), 400, CGRectGetHeight(_toUserNickName.frame))];
    self.text.text = @"聊天内容（测试）";
    [self.contentView addSubview:_text];
    


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
