//
//  FoodListModel.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "FoodListModel.h"

@implementation FoodListModel
-(instancetype)initWithFoodListBomdModel :(BmobObject *)FoodListObject
{
    self = [super init];
    if (self)
    {
       
        self.fid = [FoodListObject objectForKey:@"objectId"];
        self.foodName =[FoodListObject objectForKey:@"foodname"];
        self.foodDes =[FoodListObject objectForKey:@"fooddes"];
        self.address =[FoodListObject objectForKey:@"address"];
        self.rec =[FoodListObject objectForKey: @"rec"];
        self.sty =[FoodListObject objectForKey:@"sty"] ;
        self.score =[FoodListObject objectForKey:@"score"] ;
        self.userName  =[FoodListObject objectForKey:@"username"];
        self.picUrl = [FoodListObject objectForKey:@"picurl"];
        self.cityName = [FoodListObject objectForKey:@"city"];
        self.phone = [FoodListObject objectForKey:@"phone"];
    }
    return self;
}
@end
