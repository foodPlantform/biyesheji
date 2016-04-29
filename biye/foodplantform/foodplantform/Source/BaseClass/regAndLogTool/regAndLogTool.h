//
//  regAndLogTool.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/27.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface regAndLogTool : NSObject


+(regAndLogTool *)shareTools;
-(NSString *)registeruserwithName:(NSString *)userName password:(NSString *)passWord;
-(NSString *)loginWithName:(NSString *)userName password:(NSString *)passWord;
-(void)messageShowWith:(NSString *)message cancelStr:(NSString *)cancelStr;
@end
