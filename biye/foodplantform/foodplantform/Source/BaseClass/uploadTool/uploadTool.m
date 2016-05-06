//
//  uploadTool.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/29.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "uploadTool.h"
#import "uploadFoodViewController.h"
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

-(void)uploadWith:(foodModel *)stuff username:(NSString *)userName image:(UIImage *)img
{
    self.uploadObject = [BmobObject objectWithClassName:@"food_message"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate  dateWithTimeIntervalSinceNow:3600*2];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString * strdate = [formatter stringFromDate:date];
    NSString *fileName = [NSString stringWithFormat:@"%@%@.JPEG",userName,strdate];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.01);
    BmobFile *file = [[BmobFile alloc]initWithFileName:fileName withFileData:imageData];
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [_uploadObject setObject:file forKey:@"file"];
            [_uploadObject setObject:userName forKey:@"username"];
            [_uploadObject setObject:stuff.foodName forKey:@"foodname"];
            [_uploadObject setObject:stuff.foodDes forKey:@"fooddes"];
            [_uploadObject setObject:stuff.address forKey:@"address"];
            [_uploadObject setObject:stuff.rec forKey:@"rec"];
            [_uploadObject setObject:stuff.sty forKey:@"sty"];
            [_uploadObject setObject:file.url forKey:@"picurl"];
            
            [_uploadObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {

                    uploadFoodViewController *upVc = [[uploadFoodViewController alloc]init];
                    [upVc.hud show:NO];
                [[regAndLogTool shareTools] messageShowWith:@"上传成功" cancelStr:@"确定"];
                }
                else
                {

                    [[regAndLogTool shareTools] messageShowWith:@"上传失败" cancelStr:@"确定"];
                    
                }
            }];

        }
    }];
    
    
}

// 获取上传的数据
-(void)getuploadDataWithPassValue:(uploadData)passvalue
{
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    BmobQuery *query = [[BmobQuery alloc]initWithClassName:@"food_message"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            foodModel *fm = [[foodModel alloc]init];
            fm.fid = [obj objectForKey:@"objectid"];
            fm.foodName =[obj objectForKey:@"foodname"];
            fm.foodDes =[obj objectForKey:@"fooddes"];
            fm.address =[obj objectForKey:@"address"];
            fm.rec =[obj objectForKey: @"rec"];
            fm.sty =[obj objectForKey:@"sty"] ;
            fm.score =[obj objectForKey:@"score"] ;
            fm.userName  =[obj objectForKey:@"username"];
            fm.picUrl = [obj objectForKey:@"picurl"];
            NSLog(@"name%@",fm.foodName);
            [tempArr addObject:fm];
        }
        passvalue(tempArr);
    }];
}


@end
