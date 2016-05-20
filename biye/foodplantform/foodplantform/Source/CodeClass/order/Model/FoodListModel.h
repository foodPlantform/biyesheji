//
//  FoodListModel.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "BmobOrderModel.h"

@interface FoodListModel : BmobOrderModel
@property(nonatomic,strong)NSString *fid;
@property(nonatomic,strong)NSString *foodName;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *foodDes;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *picUrl;
@property(nonatomic,strong)NSString *rec;
@property(nonatomic,strong)NSString *sty;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *phone;
-(instancetype)initWithFoodListBomdModel :(BmobObject *)FoodListObject;


@end
