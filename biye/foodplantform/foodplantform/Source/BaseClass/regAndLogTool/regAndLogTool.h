//
//  regAndLogTool.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/27.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class userModel;


@interface regAndLogTool : NSObject
@property(nonatomic,strong)NSString *loginName;
@property(nonatomic,strong)userModel *usermodel;
@property(nonatomic,strong) UIViewController *parentVc;


+(regAndLogTool *)shareTools;
-(NSString *)registeruserwithName:(NSString *)userName password:(NSString *)passWord;
-(void)loginWithName:(NSString *)userName password:(NSString *)passWord;
-(void)messageShowWith:(NSString *)message cancelStr:(NSString *)cancelStr;
@end
