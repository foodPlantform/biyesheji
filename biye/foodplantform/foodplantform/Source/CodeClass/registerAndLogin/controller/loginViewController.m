//
//  loginViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "loginViewController.h"
#import "loginView.h"
#import "regViewController.h"
@interface loginViewController ()
@property(nonatomic,strong)loginView *lv;
@end

@implementation loginViewController
-(void)loadView
{
    self.lv = [[loginView alloc]init];
    self.view = _lv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    [self.lv.regBtn addTarget:self action:@selector(regAction) forControlEvents:UIControlEventTouchUpInside];
    [self.lv.loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)leftAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)regAction
{
    regViewController *regVc = [[regViewController alloc]init];
    //UINavigationController *regNc = [[UINavigationController alloc]initWithRootViewController:regVc];
    [self.navigationController pushViewController:regVc animated:YES];
}

// 点击登陆事件
-(void)loginBtnAction
{
    if ([self.lv.userName.text isEqualToString:@""] || [self.lv.pwStr.text isEqualToString:@""]) {
        [[regAndLogTool shareTools] messageShowWith:@"请输入完整内容" cancelStr:@"确定"];
    }
    else
    {
        //[self loginWithName:self.lv.userName.text password:self.lv.pwStr.text];
        [[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text];
        //[self.navigationController dismissViewControllerAnimated:YES completion:^{
            
       // }];
         //        if ([[[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text] isEqualToString:@"成功"]) {
//            NSLog(@"登陆成功");
//            
//        }
//        else if ([[[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text] isEqualToString:@"用户名不存在"])
//        {
//            NSLog(@"用户名不存在");
//        }
//        else if ([[[regAndLogTool shareTools] loginWithName:self.lv.userName.text password:self.lv.pwStr.text] isEqualToString:@"失败"])
//        {
//            NSLog(@"登陆失败");
//        }
        
        
    }
}

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
            [self.navigationController  dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }
        else
        {
            [[regAndLogTool shareTools] messageShowWith:@"登陆失败" cancelStr:@"确定"];
            
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
                    [self.navigationController  dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }
                else
                {
                    [[regAndLogTool shareTools] messageShowWith:@"登陆失败" cancelStr:@"确定"];
                }
            }];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
