//
//  userModel.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *passWord;
@property(nonatomic,strong)NSString *mobilePhoneNumber;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *head_img;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
