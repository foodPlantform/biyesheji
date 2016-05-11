//
//  OrderCell.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "OrderCell.h"
#define PinDanCellJianJu 10

@implementation OrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setOrderCellView];
        
    }
    return self;
}
-(void)setModel:(BmobOrderModel *)model
{
    _model = model;
    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_model.name] ;
    _foodNumLB.text = [NSString stringWithFormat:@"拼单人数:  %ld／%ld",(long)_model.currentPersonNum,(long)_model.personMaxNum] ;
    _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点:  %@",_model.foodLocation] ;
    
    //时间
    _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间:  %@",_model.timeDateStr] ;
    
    ///订单 申请的人数 及状态 4 通过 5待审核  拼单人的状态
    //订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
    if (_vcOrderType.integerValue == 1)//已完成订单
    {
        [_orderBtn setTitle:@"评论" forState:0];
    }else if (_vcOrderType.integerValue == 2)
    {
        [_orderBtn setTitle:@"同意拼单" forState:0];
        _foodUserNameLB.hidden = NO;
    }else if (_vcOrderType.integerValue == 3)
    {
        [_orderBtn setTitle:@"组队就餐" forState:0];
    }else if (_vcOrderType.integerValue == 4)//待审核订单
    {
        [_orderBtn setTitle:@"取消拼单" forState:0];
    }else if (_vcOrderType.integerValue == 5)//已审核订单
    {
         //[_orderBtn setTitle:@"删除" forState:0];
        _orderBtn.hidden = YES;
    }else
    {
       _orderBtn.hidden = YES;
    }
}
- (void)setOrderCellView
{
    _foodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    
    [self.contentView addSubview:_foodNameLB];
    _foodUserNameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_foodNameLB.frame), CGRectGetMinY(_foodNameLB.frame), kScreenWidth/2.0, 10)];
    _foodUserNameLB.text = [NSString stringWithFormat:@"申请人:  测试数据"] ;
    _foodUserNameLB.hidden =YES;

    [self.contentView addSubview:_foodUserNameLB];
    
        _foodNumLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameLB.frame), CGRectGetMaxY(_foodNameLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    
    _foodNumLB.text = [NSString stringWithFormat:@"拼单对象:  测试数据"] ;
    
    [self.contentView addSubview:_foodNumLB];
    _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderBtn.frame = CGRectMake(CGRectGetMaxX(_foodNumLB.frame)+PinDanCellJianJu*2, CGRectGetMinY(_foodNumLB.frame), kScreenWidth/4.0, 25);
    [_orderBtn addTarget:self action:@selector(handleOrder) forControlEvents:UIControlEventTouchUpInside];
    _orderBtn.backgroundColor = [UIColor redColor];
    [_orderBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_orderBtn setTitle:@"aaaaaaa" forState:0];
    
    [self.contentView addSubview:_orderBtn];
    _foodTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameLB.frame), CGRectGetMaxY(_foodNumLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 10)];
   
    NSLog(@"%.f",CGRectGetMinX(_orderBtn.frame));

    [self.contentView addSubview:_foodTimeLB];
    
    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodTimeLB.frame), CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu, kScreenWidth/1.5, 50)];
    _foodLocationLB.text = [NSString stringWithFormat:@"约吃地点:  测试数据"] ;
    _foodLocationLB.numberOfLines = 0;
    _foodLocationLB.textAlignment =0;
    [self.contentView addSubview:_foodLocationLB];
    
    NSLog(@"%.f",CGRectGetMaxY(_foodLocationLB.frame));
}
 - (void)handleOrder
{
    if ([_delegate respondsToSelector:@selector(handleOrderCell:model:)]) {
        [_delegate handleOrderCell:self model:_model];
    }
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
