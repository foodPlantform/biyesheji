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
    NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1/mwh/mwhregister.php?username=%@&pwd=%@",userName,passWord];
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
-(void)loginWithName:(NSString *)userName password:(NSString *)passWord
{
//    // GET请求  同步
//    // 1. 准备URL
//    NSString *urlStr = [NSString stringWithFormat:@"http://zhaohm.com.cn/hm/hmweb/mwh/mwhlogin.php?username=%@&pwd=%@",userName,passWord];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    // 2. 准备请求
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    // 3. 准备数据
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    // 4. 解析
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSMutableString *logStr = [dict valueForKey:@"result"];
//    return logStr;

    self.loginName = [NSString string];
    [self.loginName addObserver:self forKeyPath:@"login" options:NSKeyValueObservingOptionOld| NSKeyValueObservingOptionNew context:nil];
    self.usermodel = [[userModel alloc]init];
    [BmobUser loginInbackgroundWithAccount:userName andPassword:passWord block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"phoneSuccess");
            NSLog(@"%@",user);
           
            [self setValue:userName forKey:@"loginName"];
            BmobQuery *q = [BmobQuery queryWithClassName:@"_User"];
            [q whereKey:@"mobilePhoneNumber" equalTo:userName];
            [q findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                for (BmobObject *obj in array) {
                    _usermodel.userName = [obj valueForKey:@"username"];
                    _usermodel.mobilePhoneNumber = [obj valueForKey:@"mobilePhoneNumber"];
//                    _usermodel.gender = [obj valueForKey:@"gender"];
//                    _usermodel.head_img = [obj valueForKey:@"head_img"];
                }
            }];
            //更新用户的 deviceToken
            [user setObject:[[FileManager shareManager] currentDeviceToken] forKey:@"deviceToken"];

            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
            }];

        }
        else
        {
            
        }
    }];
    BmobQuery *query = [BmobQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        for (BmobObject *obj in array) {
            NSString *phone = [obj objectForKey:@"mobilePhoneNumber"];
            [BmobUser loginInbackgroundWithAccount:phone andPassword:passWord block:^(BmobUser *user, NSError *error) {
                if (user) {
                    [self setValue:userName forKey:@"loginName"];
                    NSLog(@"success");
                    NSLog(@"%@",user);
                    BmobQuery *q = [BmobQuery queryWithClassName:@"_User"];
                    [q whereKey:@"username" equalTo:userName];
                    [q findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        for (BmobObject *obj in array) {
                            _usermodel.userName = [obj valueForKey:@"username"];
                            _usermodel.mobilePhoneNumber = [obj valueForKey:@"mobilePhoneNumber"];
//                            _usermodel.gender = [obj valueForKey:@"gender"];
//                            _usermodel.head_img = [obj valueForKey:@"head_img"];
                        }
                    }];
                }
            }];
        }
    }];
    
}

@end
