//
//  uploadTool.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/29.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "uploadTool.h"

static uploadTool *ut;
@implementation uploadTool
+(uploadTool *)shareTool
{
    static dispatch_once_t once_Token;
    if (ut == nil) {
        dispatch_once(&once_Token, ^{
            ut = [[uploadTool alloc]init];
        });
    }
    return ut;
}
-(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (images==nil) {
            return ;
        }
        for (UIImage *image in images) {
            NSData *imageData = UIImagePNGRepresentation(image);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSLog(@"%@",fileName);
            
            /*
             此方法参数
             1. 要上传的[二进制数据]
             2. 对应网站上[upload.php中]处理文件的[字段"file"]
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
            
        }
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

// 上传信息
-(void)uploadWithusername:(NSString *)userName foodname:(NSString *)foodName fooddes:(NSString *)foodDes Address:(NSString *)address Rec:(NSString *)rec Sty:(NSString *)sty Img:(NSString *)img
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"username",foodName,@"foodname",foodDes,@"fooddes",address,@"address",rec,@"rec",sty,@"sty",img,@"img", nil];
    [manager POST:@"" parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
    
}

@end
