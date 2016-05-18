//
//  FileManager.h
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/7.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FileManager : NSObject
+(FileManager *)shareManager;

-(BOOL)isUserLogin;
//没有登陆 跳到登陆界面
- (void)LoginWithVc:(UIViewController *)vc;
//保存 用户的当前的currentDeviceToken
-(NSString *)currentDeviceToken;
@end
