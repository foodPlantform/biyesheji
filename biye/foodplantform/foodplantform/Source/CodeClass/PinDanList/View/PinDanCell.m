//
//  PinDanCell.m
//  foodplantform
//
//  Created by 仇亚利 on 16/4/22.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "PinDanCell.h"
#define PinDanCellJianJu 10


@implementation PinDanCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setPanDanCellView];

    }
    return self;
}
-(void)setModel:(BmobOrderModel *)model
{
    _model = model;
    [_userImgV sd_setImageWithURL:[NSURL URLWithString: _model.userImgeUrl ]];
    [_userNiChengBtn setTitle:[NSString stringWithFormat:@" 发单人:  %@" ,_model.niCheng] forState:0];
    //_userNiChengLB.text = [NSString stringWithFormat:@" 发单人:  %@" ,_model.niCheng];

    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_model.name] ;
    _foodPersonNumLB.text = [NSString stringWithFormat:@"拼单人数:  %ld／%ld",(long)_model.currentPersonNum,(long)_model.personMaxNum] ;
    _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点:  %@",_model.foodLocation] ;
    _userSexAgeLB.text = [NSString stringWithFormat:@"预算金额: ¥%@",_model.orderPrice] ;
    _foodPayTypeLB.text = [NSString stringWithFormat:@"付款方式: %@",_model.foodPayType.intValue==0?@"我付":@"AA制"];

    //时间
    _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间:  %@",_model.timeDateStr] ;
    switch (_model.target.integerValue) {
        case 0://不限
        {
            _foodPersonLB.text = [NSString stringWithFormat:@"拼单对象:  不限性别"] ;

        }
            break;
        case 1://只约男性
        {
            _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象:  只约男性"] ;

        }
            break;
        case 2://女性
        {
            _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象:  只约女性"] ;

        }
            break;


        default:
            break;
    }
    //距离
    CLLocation *bmobLocation = [[CLLocation alloc] initWithLatitude:_model.foodLocationLatitude longitude:_model.foodLocationLongitude];
    //CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:_model.foodLocationLatitude longitude:_model.foodLocationLongitude];
    CLLocationDistance kilometers=[_currentLocation distanceFromLocation:bmobLocation];
    NSLog(@"距离:%f",kilometers);
    if (kilometers >1000) {
        _foodKMLB.text = [NSString stringWithFormat:@"地点距离:  %.2f km",kilometers/1000] ;
    }else
    {
        _foodKMLB.text = [NSString stringWithFormat:@"地点距离:  %.2f m",kilometers] ;
    }
    

}
//显示已完成的拼单
- (void)showOldOrder
{
    if ([_delegate respondsToSelector:@selector(showOldOrderPinDanCell:model:)])
    {
        [_delegate showOldOrderPinDanCell:self model:_model];
    }
}
//加好友
- (void)addSendOrderPriend
{
    if ([_delegate respondsToSelector:@selector(addSenderFriendOrderPinDanCell:model:)])
    {
        [_delegate addSenderFriendOrderPinDanCell:self model:_model];
    }
}
- (void)setPanDanCellView
{
   /*
    @property(nonatomic,strong)UIImageView *userImg;
    @property(nonatomic,strong)UILabel *userNiChengLB;
    @property(nonatomic,strong)UILabel *userSexAgeLB;
    
    @property(nonatomic,strong)UILabel *foodNameLB;
    @property(nonatomic,strong)UILabel *foodTimeLB;
    @property(nonatomic,strong)UILabel *foodLocationLB;
    */
    _userImgV = [[UIImageView alloc]initWithFrame:CGRectMake(PinDanCellJianJu, PinDanCellJianJu, 100, 100) ];
    [self.contentView addSubview:_userImgV];
    _userImgV.backgroundColor = [UIColor yellowColor];
    _userNiChengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userNiChengBtn addTarget:self action:@selector(showOldOrder) forControlEvents:UIControlEventTouchUpInside];
    _userNiChengBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_userNiChengBtn setTitleColor:[UIColor blackColor] forState:0];
    // _userNiChengBtn.backgroundColor = [UIColor blackColor];
    _userNiChengBtn.frame = CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu, CGRectGetMinY(_userImgV.frame), kScreenWidth/3.0, 30);
    
    [self.contentView addSubview:_userNiChengBtn];
    _addSenderFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addSenderFriendBtn addTarget:self action:@selector(addSendOrderPriend) forControlEvents:UIControlEventTouchUpInside];
    [_addSenderFriendBtn setTitle:@"加好友" forState:0];
    [_addSenderFriendBtn setTitleColor:[UIColor redColor] forState:0];
    _addSenderFriendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // _userNiChengBtn.backgroundColor = [UIColor blackColor];
    _addSenderFriendBtn.frame = CGRectMake(CGRectGetMaxX(_userNiChengBtn.frame)+PinDanCellJianJu, CGRectGetMinY(_userImgV.frame), kScreenWidth/3.0, 30);
    
    [self.contentView addSubview:_addSenderFriendBtn];
//    _userNiChengLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu, CGRectGetMinY(_userImgV.frame), kScreenWidth/3.0, 10)];
//    _userNiChengLB.text = [NSString stringWithFormat:@"昵称:  测试昵称"];
//    [self.contentView addSubview:_userNiChengLB];
    
    _userSexAgeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu,  CGRectGetMaxY(_userNiChengBtn.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
//    _userSexAgeLB.hidden =YES;
    
    _userSexAgeLB.text = [NSString stringWithFormat:@"性别／年龄: 测试性别＋年龄"];
    [self.contentView addSubview:_userSexAgeLB];
    _foodPayTypeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu,  CGRectGetMaxY(_userSexAgeLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _foodPayTypeLB.text = [NSString stringWithFormat:@"付款方式: 测试"];
    [self.contentView addSubview:_foodPayTypeLB];
    
    _foodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_userImgV.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_model.name] ;
    
    [self.contentView addSubview:_foodNameLB];
    
    
    _foodPersonLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodNameLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    
    _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象:  测试数据"] ;
    
    [self.contentView addSubview:_foodPersonLB];
        _foodPersonNumLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodPersonLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _foodPersonNumLB.text = [NSString stringWithFormat:@"约吃人数:  %ld／%ld",(long)_model.currentPersonNum,(long)_model.personMaxNum] ;
    
    [self.contentView addSubview:_foodPersonNumLB];

    
    _addPindanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addPindanBtn.frame = CGRectMake(kScreenWidth -kScreenWidth/5.0-10, CGRectGetMaxY(_foodPersonLB.frame)+PinDanCellJianJu*2, kScreenWidth/5.0, 40);
    [_addPindanBtn setTitle:@"加入拼单" forState:UIControlStateNormal];
    [_addPindanBtn addTarget:self action:@selector(addPindanBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _addPindanBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_addPindanBtn];

    _foodTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodPersonNumLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 10)];
    
    
    [self.contentView addSubview:_foodTimeLB];

    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 10)];
    _foodLocationLB.text = [NSString stringWithFormat:@"约吃地点:  测试数据"] ;
    
    [self.contentView addSubview:_foodLocationLB];
    
    _foodKMLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodLocationLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 10)];
    _foodKMLB.text = [NSString stringWithFormat:@"地点距离:  测试数据"] ;
    
    [self.contentView addSubview:_foodKMLB];
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetHeight(self.frame)-1, kScreenWidth-10, 1)];
//    lineView.backgroundColor = [UIColor blackColor];
//    [self.contentView addSubview:lineView];
    NSLog(@"%.f",CGRectGetMaxY(_foodKMLB.frame));
}
//加入拼单
- (void)addPindanBtnAction
{
    if ([_delegate respondsToSelector:@selector(addOrderPinDanCell:model:)])
    {
        [_delegate addOrderPinDanCell:self model:_model];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
