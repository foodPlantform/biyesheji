//
//  regViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "regViewController.h"
#import "regView.h"

@interface regViewController ()
@property(nonatomic,strong)regView *rv;
@end

@implementation regViewController

-(void)loadView
{
    [super viewDidLoad];
    self.rv = [[regView alloc]init];
    self.view = _rv;
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    [self.rv.regBtn addTarget:self action:@selector(regAction:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)viewDidLoad {
        // Do any additional setup after loading the view.
}

-(void)leftAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//注册按钮点击事件
-(void)regAction:(id) sender
{
    if ([self.rv.userName.text  isEqual:@""] || [self.rv.pwStr.text  isEqual: @""] || [self.rv.ensurePwStr.text isEqualToString:@""]) {
        UIAlertView * mes = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [mes show];
    }
    
    else
    {
        if (![self.rv.pwStr.text isEqualToString:self.rv.ensurePwStr.text]) {
            UIAlertView * mes1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [mes1 show];
        }
        else
        {
            // GET请求  同步
            // 1. 准备URL
            NSString *urlStr = [NSString stringWithFormat:@"http://zhaohm.com.cn/hm/hmWeb/server/mwh/mwhregister.php?username=%@&pwd=%@",self.rv.userName.text,self.rv.pwStr.text];
            NSURL *url = [NSURL URLWithString:urlStr];
            // 2. 准备请求
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"GET"];
            // 3. 准备数据
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            // 4. 解析
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"%@",dict );
        }
    }
  

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
