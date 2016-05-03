//
//  foodModel.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/2.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface foodModel : NSObject
@property(nonatomic,strong)NSString *foodName;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *foodDes;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *picUrl;
@property(nonatomic,strong)NSString *rec;
@property(nonatomic,strong)NSString *sty;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
