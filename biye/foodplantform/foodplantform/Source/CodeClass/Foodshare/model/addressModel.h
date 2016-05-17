//
//  addressModel.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressModel : NSObject
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *phonenow;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *address;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
