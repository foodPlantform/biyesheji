//
//  uploadTool.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/29.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uploadTool : NSObject


+(uploadTool *)shareTool;

-(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void (^)(id))success failure:(void (^)(NSError *))failure;

-(void)uploadWithusername:(NSString *)userName foodname:(NSString *)foodName fooddes:(NSString *)foodDes Address:(NSString *)address Rec:(NSString *)rec Sty:(NSString *)sty Img:(NSString *)img;
@end
