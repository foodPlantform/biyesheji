//
//  userModel.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/27.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *passWord;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
