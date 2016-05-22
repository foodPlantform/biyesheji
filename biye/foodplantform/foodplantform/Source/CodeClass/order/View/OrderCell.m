//
//  OrderCell.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "OrderCell.h"
#define PinDanCellJianJu 10
@interface OrderCell ()
@property (nonatomic,strong)BmobOrderModel *handelModel;
@property (nonatomic,strong)FoodListModel *handelFoodModel;


@end
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
-(void)setVcOrderOrFoodType:(NSString *)vcOrderOrFoodType
{
    _vcOrderOrFoodType= vcOrderOrFoodType;
    if (_vcOrderOrFoodType.integerValue ==0) {
        
        if (_vcOrderType.integerValue == 0 )
        {
            _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_model.name] ;
            _foodNumLB.text = [NSString stringWithFormat:@"拼单人数:  %ld／%ld",(long)_model.currentPersonNum,(long)_model.personMaxNum] ;
            _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点:  %@",_model.foodLocation] ;
            
            //时间
            _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间:  %@",_model.timeDateStr] ;
        }else if(_vcOrderType.integerValue == 2||_vcOrderType.integerValue == 3)
            //当ordeType 为2  3  4 5 需要处理 重新查找order表
        {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"user_order" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelModel  = [[BmobOrderModel alloc] initWithBomdModel:array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_handelModel.name] ;
                _foodNumLB.text = [NSString stringWithFormat:@"拼单人数:  %ld／%ld",(long)_handelModel.currentPersonNum,(long)_handelModel.personMaxNum] ;
                _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点:  %@",_handelModel.foodLocation] ;
                
                //时间
                _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间:  %@",_handelModel.timeDateStr] ;
                //申请人
                //            _foodUserNameLB.text = [NSString stringWithFormat:@"申请人:   %@" ,_model.applyUserListName] ;
                //            _foodUserNameLB.hidden = NO;
                [_foodUserNameBtn setTitle:  [NSString stringWithFormat:@"申请人:   %@" ,_model.applyUserListName]  forState:0];
                _foodUserNameBtn.userInteractionEnabled = YES;
                _foodUserNameBtn.hidden = NO;
            }];
            
            
        }else if (_vcOrderType.integerValue == 4||_vcOrderType.integerValue == 5) {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"user_order" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelModel  = [[BmobOrderModel alloc] initWithBomdModel:array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_handelModel.name] ;
                _foodNumLB.text = [NSString stringWithFormat:@"拼单人数:  %ld／%ld",(long)_handelModel.currentPersonNum,(long)_handelModel.personMaxNum] ;
                _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点:  %@",_handelModel.foodLocation] ;
                
                //时间
                _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间:  %@",_handelModel.timeDateStr] ;
                //审核人
                [_foodUserNameBtn setTitle:  [NSString stringWithFormat:@"审核人:   %@" ,_model.senderUserListName]  forState:0];
                _foodUserNameBtn.userInteractionEnabled = NO;
                _foodUserNameBtn.hidden = NO;
            }];
        }else if (_vcOrderType.integerValue == 1) {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"user_order" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelModel  = [[BmobOrderModel alloc] initWithBomdModel:array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_handelModel.name] ;
                _foodNumLB.text = [NSString stringWithFormat:@"拼单人数:  %ld／%ld",(long)_handelModel.currentPersonNum,(long)_handelModel.personMaxNum] ;
                _foodLocationLB.text = [NSString stringWithFormat:@"拼单地点:  %@",_handelModel.foodLocation] ;
                
                //时间
                _foodTimeLB.text = [NSString stringWithFormat:@"拼单时间:  %@",_handelModel.timeDateStr] ;
                _foodUserNameLB.hidden = YES;
            }];
        }
#pragma mark -  美食显示逻辑
    } else
    {
        if (_vcOrderType.integerValue ==0) {
            _foodNameLB.text = [NSString stringWithFormat:@"美食名称 :  %@",_foodListModel.foodName] ;
            
            _foodLocationLB.text = [NSString stringWithFormat:@" 美食地点:  %@",_foodListModel.address] ;
            
            //时间
            _foodNumLB.text = [NSString stringWithFormat:@"美食详情:  %@",_foodListModel.foodDes] ;
        }else if (_vcOrderType.integerValue ==1)//已完成美食
        {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"food_message" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelFoodModel  = [[FoodListModel alloc]initWithFoodListBomdModel :array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"美食名称 :  %@",_handelFoodModel.foodName] ;
                _foodLocationLB.text = [NSString stringWithFormat:@" 美食地点:  %@",_handelFoodModel.address] ;
                //时间
                _foodNumLB.text = [NSString stringWithFormat:@"美食详情:  %@",_handelFoodModel.foodDes] ;
            }];
        }
        else if (_vcOrderType.integerValue ==2)//待处理美食
        {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"food_message" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelFoodModel  = [[FoodListModel alloc]initWithFoodListBomdModel :array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"美食名称 :  %@",_handelFoodModel.foodName] ;
                _foodLocationLB.text = [NSString stringWithFormat:@" 美食地点:  %@",_handelFoodModel.address] ;
                //时间
                _foodNumLB.text = [NSString stringWithFormat:@"美食详情:  %@",_handelFoodModel.foodDes] ;
                [_foodUserNameBtn setTitle:  [NSString stringWithFormat:@"申请人:   %@" ,_model.applyUserListName]  forState:0];
                _foodUserNameBtn.userInteractionEnabled = YES;
                _foodUserNameBtn.hidden = NO;
            } ];
        }
        else if (_vcOrderType.integerValue ==3)//已处理美食
        {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"food_message" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelFoodModel  = [[FoodListModel alloc]initWithFoodListBomdModel :array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"美食名称 :  %@",_handelFoodModel.foodName] ;
                _foodLocationLB.text = [NSString stringWithFormat:@" 美食地点:  %@",_handelFoodModel.address] ;
                //时间
                _foodNumLB.text = [NSString stringWithFormat:@"美食详情:  %@",_handelFoodModel.foodDes] ;
                [_foodUserNameBtn setTitle:  [NSString stringWithFormat:@"申请人:   %@" ,_model.applyUserListName]  forState:0];
                _foodUserNameBtn.userInteractionEnabled = YES;
                _foodUserNameBtn.hidden = NO;}];
        }
        else if (_vcOrderType.integerValue ==4)//待审核美食
        {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"food_message" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelFoodModel  = [[FoodListModel alloc]initWithFoodListBomdModel :array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"美食名称 :  %@",_handelFoodModel.foodName] ;
                _foodLocationLB.text = [NSString stringWithFormat:@" 美食地点:  %@",_handelFoodModel.address] ;
                //时间
                _foodNumLB.text = [NSString stringWithFormat:@"美食详情:  %@",_handelFoodModel.foodDes] ;
                [_foodUserNameBtn setTitle:  [NSString stringWithFormat:@"审核人:   %@" ,_model.senderUserListName]  forState:0];
                NSLog(@"  [_foodUserNameBtn currentTitle]-------%@",  [_foodUserNameBtn currentTitle]);
              
                _foodUserNameBtn.userInteractionEnabled = NO;
                _foodUserNameBtn.hidden = NO;
            }];
        }
        else if (_vcOrderType.integerValue ==5)//已审核美食
        {
            BmobQuery   *handelOrderQuery = [BmobQuery queryWithClassName:@"food_message" ];
            [handelOrderQuery whereKey:@"objectId" equalTo:_model.orderListID];
            [handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (array.count == 0)return ;
                _handelFoodModel  = [[FoodListModel alloc]initWithFoodListBomdModel :array[0]];
                _foodNameLB.text = [NSString stringWithFormat:@"美食名称 :  %@",_handelFoodModel.foodName] ;
                _foodLocationLB.text = [NSString stringWithFormat:@" 美食地点:  %@",_handelFoodModel.address] ;
                //时间
                _foodNumLB.text = [NSString stringWithFormat:@"美食详情:  %@",_handelFoodModel.foodDes] ;
                [_foodUserNameBtn setTitle:  [NSString stringWithFormat:@"审核人:   %@" ,_model.senderUserListName]  forState:0];
                _foodUserNameBtn.userInteractionEnabled = NO;
                _foodUserNameBtn.hidden = NO;
            }];
        }
    }
    
    
    ///订单 申请的人数 及状态 5 通过 4待审核  拼单人的状态
    //订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
    
    if (_vcOrderOrFoodType.integerValue == 0) {
        if (_vcOrderType.integerValue == 1)//已完成订单
        {
            [_orderBtn setTitle:@"评论" forState:0];
            _orderBtn.hidden = NO;
            //        [_orderChatBtn setTitle:@"加好友" forState:0];
            //        _orderChatBtn.hidden =NO;
        }else if (_vcOrderType.integerValue == 2)
        {
            [_orderBtn setTitle:@"同意拼单" forState:0];
            [_orderChatBtn setTitle:@"不同意" forState:0];
            _orderBtn.hidden = NO;
            _orderChatBtn.hidden =NO;
        }else if (_vcOrderType.integerValue == 3)
        {
            [_orderBtn setTitle:@"已完成" forState:0];
            [_orderChatBtn setTitle:@"群聊" forState:0];
            [_addFriendBtn setTitle:@"加好友" forState:0];
            _addFriendBtn.hidden = NO;
            _orderBtn.hidden = NO;
            _orderChatBtn.hidden =NO;
        }else if (_vcOrderType.integerValue == 4)//待审核订单
        {
            //[_orderBtn setTitle:@"取消拼单" forState:0];
            _orderBtn.hidden = YES;
            
        }else if (_vcOrderType.integerValue == 5)//已审核订单
        {
            
        }else
        {
            _orderBtn.hidden = YES;
        }
        // 第一个btn已完成 评论 同意
        [_orderBtn addTarget:self action:@selector(handleOrder) forControlEvents:UIControlEventTouchUpInside];
        // 第btn 群聊 不同意
        [_orderChatBtn addTarget:self action:@selector(orderChatBtnAction) forControlEvents:UIControlEventTouchUpInside];
        //  加好友btn
        [_addFriendBtn addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
        // 查看评论的btn
         [_foodUserNameBtn addTarget:self action:@selector(showUserPinglun) forControlEvents:UIControlEventTouchUpInside];
    }else if (vcOrderOrFoodType.integerValue ==1)//美食处理事件
    {
        if (_vcOrderType.integerValue == 1)//已完成订单
        {
            [_orderBtn setTitle:@"评论" forState:0];
            _orderBtn.hidden = NO;
            //        [_orderChatBtn setTitle:@"加好友" forState:0];
            //        _orderChatBtn.hidden =NO;
        }else if (_vcOrderType.integerValue == 2)
        {
            [_orderBtn setTitle:@"同意" forState:0];
            [_orderChatBtn setTitle:@"不同意" forState:0];
            _orderBtn.hidden = NO;
            _orderChatBtn.hidden =NO;
        }else if (_vcOrderType.integerValue == 3)
        {
//            [_orderBtn setTitle:@"已完成" forState:0];
//            
//            _orderBtn.hidden = NO;

        }else if (_vcOrderType.integerValue == 4)//待审核订单
        {
            //[_orderBtn setTitle:@"取消拼单" forState:0];
            _orderBtn.hidden = YES;
            
        }else if (_vcOrderType.integerValue == 5)//已审核订单
        {
            [_orderBtn setTitle:@"已完成" forState:0];
            
            _orderBtn.hidden = NO;
        }else
        {
            _orderBtn.hidden = YES;
        }
        // 第一个btn已完成 评论 同意
        [_orderBtn addTarget:self action:@selector(handleFood) forControlEvents:UIControlEventTouchUpInside];
        // 不同意
        [_orderChatBtn addTarget:self action:@selector(nohandleFood) forControlEvents:UIControlEventTouchUpInside];
        _foodUserNameBtn.userInteractionEnabled = YES;
    }
   
}
-(void)setModel:(UserApplyListModel *)model
{
    _model = model;
   
}
- (void)setOrderCellView
{
    _foodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(PinDanCellJianJu, PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    
    [self.contentView addSubview:_foodNameLB];
//    _foodUserNameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_foodNameLB.frame), CGRectGetMinY(_foodNameLB.frame), kScreenWidth/2.0, 10)];
//    _foodUserNameLB.text = [NSString stringWithFormat:@"申请人:  测试数据"] ;
//    _foodUserNameLB.hidden =YES;
//
//    [self.contentView addSubview:_foodUserNameLB];
    _foodUserNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_foodNameLB.frame), CGRectGetMinY(_foodNameLB.frame), kScreenWidth/2.0, 20)];
    [_foodUserNameBtn setTitle: [NSString stringWithFormat:@"申请人:  测试数据"]  forState:0];
    [_foodUserNameBtn setTitleColor:[UIColor redColor] forState:0];
    _foodUserNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //_foodUserNameBtn.backgroundColor = [UIColor redColor];
//    [_foodUserNameBtn addTarget:self action:@selector(showUserPinglun) forControlEvents:UIControlEventTouchUpInside];
    _foodUserNameBtn.hidden =YES;
    
    [self.contentView addSubview:_foodUserNameBtn];
    
        _foodNumLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameLB.frame), CGRectGetMaxY(_foodNameLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    
    _foodNumLB.text = [NSString stringWithFormat:@"拼单对象:  测试数据"] ;
    
    [self.contentView addSubview:_foodNumLB];
    // order的处理时间
    _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderBtn.frame = CGRectMake(CGRectGetMaxX(_foodNumLB.frame)+PinDanCellJianJu, CGRectGetMinY(_foodNumLB.frame), kScreenWidth/5.0, 25);
//    [_orderBtn addTarget:self action:@selector(handleOrder) forControlEvents:UIControlEventTouchUpInside];
    _orderBtn.backgroundColor = [UIColor redColor];
    [_orderBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_orderBtn setTitle:@"aaaaaaa" forState:0];
    _orderBtn.hidden = YES;
    [self.contentView addSubview:_orderBtn];
    // 用户的处理事件
    _orderChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderChatBtn.frame = CGRectMake(CGRectGetMaxX(_orderBtn.frame)+PinDanCellJianJu*2, CGRectGetMinY(_foodNumLB.frame), kScreenWidth/6.0, 25);
//    [_orderChatBtn addTarget:self action:@selector(orderChatBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _orderChatBtn.backgroundColor = [UIColor redColor];
    [_orderChatBtn setTitleColor:[UIColor whiteColor] forState:0];
   
    _orderChatBtn.hidden = YES;
    [self.contentView addSubview:_orderChatBtn];
     //加好友
    _addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addFriendBtn.frame = CGRectMake(CGRectGetMinX(_orderChatBtn.frame), CGRectGetMaxY(_orderChatBtn.frame)+5, CGRectGetWidth(_orderChatBtn.frame), 25);
//    [_addFriendBtn addTarget:self action:@selector(orderChatBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _addFriendBtn.backgroundColor = [UIColor redColor];
    [_addFriendBtn setTitleColor:[UIColor whiteColor] forState:0];
    
    _addFriendBtn.hidden = YES;
    [self.contentView addSubview:_addFriendBtn];
    _foodTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodNameLB.frame), CGRectGetMaxY(_foodNumLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.2, 10)];
   
    NSLog(@"%.f",CGRectGetMinX(_orderBtn.frame));

    [self.contentView addSubview:_foodTimeLB];
    
    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_foodTimeLB.frame), CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu, kScreenWidth/1.5, 50)];
    _foodLocationLB.text = [NSString stringWithFormat:@"约吃地点:  测试数据"] ;
    _foodLocationLB.numberOfLines = 0;
    _foodLocationLB.textAlignment =0;
    [self.contentView addSubview:_foodLocationLB];
    
    NSLog(@"%.f",CGRectGetMaxY(_foodLocationLB.frame));
}
#pragma mark - 订单处理事件
//处理的第一个按钮
 - (void)handleOrder
{
    if ([_delegate respondsToSelector:@selector(handleOrderCell:model:handeledModel:)]) {
        [_delegate handleOrderCell:self model:_model handeledModel:_handelModel];
    }
}
//处理的第 二个按钮
- (void)orderChatBtnAction{
    if ([_delegate respondsToSelector:@selector(ChatOrderCell:model:handeledModel:)]) {
        [_delegate ChatOrderCell:self model:_model handeledModel:_handelModel];
    }
}
//查看申请人的评论
- (void)showUserPinglun
{
    if ([_delegate respondsToSelector:@selector(showPinlunCell:model:handeledModel:)]) {
        [_delegate showPinlunCell:self model:_model handeledModel:_handelModel];
    }
}
//加好友
- (void)addFriendAction
{
    if ([_delegate respondsToSelector:@selector(AddFriendPinlunCell:model:handeledModel:)]) {
        [_delegate AddFriendPinlunCell:self model:_model handeledModel:_handelModel];
    }
}
#pragma mark - 美食处理事件
// 评论 同意  已完成
-  (void)handleFood
{
    if ([_delegate respondsToSelector:@selector(handleFoodCell:model:handeledModel:)]) {
        [_delegate handleFoodCell:self model:_model handeledModel:_handelFoodModel];
    }
}
//不同意
-  (void)nohandleFood
{
    if ([_delegate respondsToSelector:@selector(noAgreeFoodCell:model:handeledModel:)]) {
        [_delegate noAgreeFoodCell:self model:_model handeledModel:_handelFoodModel];
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
