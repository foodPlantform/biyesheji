//
//  regAndLogTool.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/27.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "regAndLogTool.h"
#import "userModel.h"

static regAndLogTool *rlt;
@implementation regAndLogTool
+(regAndLogTool *)shareTools
{
    static dispatch_once_t once_token;
    if (rlt == nil) {
        dispatch_once(&once_token, ^{
            rlt = [[regAndLogTool alloc]init];
        });
    }
    return rlt;
}

-(void)messageShowWith:(NSString *)message cancelStr:(NSString *)cancelStr
{
    UIAlertView *mess = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:cancelStr otherButtonTitles:nil, nil];
    [mess show];
}
// 用户注册
-(NSString *)registeruserwithName:(NSString *)userName password:(NSString *)passWord
{
    
    // GET请求  同步
    // 1. 准备URL
    NSString *urlStr = [NSString stringWithFormat:@"http://zhaohm.com.cn/hm/hmweb/mwh/mwhregister.php?username=%@&pwd=%@",userName,passWord];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 准备请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    // 3. 准备数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // 4. 解析
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableString *regStr = [dict valueForKey:@"result"];
    return regStr;
    

    
}


// 用户登陆
-(NSString *)loginWithName:(NSString *)userName password:(NSString *)passWord
{
    // GET请求  同步
    // 1. 准备URL
    NSString *urlStr = [NSString stringWithFormat:@"http://zhaohm.com.cn/hm/hmweb/mwh/mwhlogin.php?username=%@&pwd=%@",userName,passWord];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 准备请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    // 3. 准备数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // 4. 解析
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableString *logStr = [dict valueForKey:@"result"];
    return logStr;

}

@end
