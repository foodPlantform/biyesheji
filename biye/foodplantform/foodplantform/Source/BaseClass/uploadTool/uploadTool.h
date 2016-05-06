//
//  uploadTool.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/29.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
@class foodModel;
typedef void(^uploadData)(NSArray *upArr);
@interface uploadTool : NSObject
@property(nonatomic,strong)BmobObject *uploadObject;
@property(nonatomic,strong)NSMutableString *uploadResult;

+(uploadTool *)shareTool;

-(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void (^)(id))success failure:(void (^)(NSError *))failure;

-(void)uploadWithusername:(NSString *)userName foodname:(NSString *)foodName fooddes:(NSString *)foodDes Address:(NSString *)address Rec:(NSString *)rec Sty:(NSString *)sty Img:(NSString *)img;

// 上传数据
-(void)uploadWith:(foodModel *)stuff username:(NSString *)userName image:(UIImage *)img;

// 获取上传的数据
-(void)getuploadDataWithPassValue:(uploadData)passvalue;
@end
