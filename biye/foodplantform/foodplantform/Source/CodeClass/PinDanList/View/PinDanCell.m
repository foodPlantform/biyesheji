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
    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_model.name] ;
    _foodPersonNumLB.text = [NSString stringWithFormat:@"约吃人数:  %@／%@",_model.currentPersonNum,_model.personMaxNum] ;
    _foodLocationLB.text = [NSString stringWithFormat:@"约吃地点:  %@",_model.foodLocation] ;
    
    _foodPayTypeLB.text = [NSString stringWithFormat:@"付款方式: %@",_model.foodPayType.intValue==0?@"我付":@"AA制"];

    //时间
    _foodTimeLB.text = [NSString stringWithFormat:@"约吃时间:  %@",_model.timeDateStr] ;
    switch (_model.target.integerValue) {
        case 0://不限
        {
            _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象:  不限性别"] ;

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
    CLLocationDistance kilometers=[_currentLocation distanceFromLocation:bmobLocation]/1000;
    NSLog(@"距离:%f",kilometers);
    _foodKMLB.text = [NSString stringWithFormat:@"地点距离:  %.2f km",kilometers] ;

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
    
    _userNiChengLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu, CGRectGetMinY(_userImgV.frame), kScreenWidth/3.0, 10)];
    _userNiChengLB.text = [NSString stringWithFormat:@"昵称:  测试昵称"];
    [self.contentView addSubview:_userNiChengLB];
    
    _userSexAgeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu,  CGRectGetMaxY(_userNiChengLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
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
    _foodPersonNumLB.text = [NSString stringWithFormat:@"约吃人数:  %@／%@",_model.currentPersonNum,_model.personMaxNum] ;
    
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
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
