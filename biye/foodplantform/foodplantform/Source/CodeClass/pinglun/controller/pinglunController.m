//
//  pinglunController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "pinglunController.h"
#import "pinglunView.h"

@interface pinglunController ()
@property(nonatomic,strong)pinglunView *pv;
@property(nonatomic,strong)NSMutableString *starStr;
@property(nonatomic,strong) MBProgressHUD *hud;
@end

@implementation pinglunController
-(void)loadView
{
    self.pv = [[pinglunView alloc]init];
    self.view = _pv;
}
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pv.sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    // 添加星星点击事件
    [self.pv.star addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)starAction:(HCSStarRatingView *)sender
{
    self.starStr = [NSMutableString stringWithFormat:@"%f",sender.value];
    NSLog(@"%.1f",sender.value);
}
-(void)sureAction
{
    [self p_setupProgressHud];
    BmobUser *user = [BmobUser getCurrentUser];
    
    BmobObject *obj = [BmobObject objectWithClassName:@"pinglun"];
    [obj setObject:user.username forKey:@"username"];
    [obj setObject:user.mobilePhoneNumber forKey:@"userphone"];
    [obj setObject:self.pv.pinglun.text forKey:@"content"];
    [obj setObject:self.starStr forKey:@"star"];
    
    
    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
       
        if (isSuccessful) {
            [[regAndLogTool shareTools] messageShowWith:@"评论成功" cancelStr:@"确定"];
            self.hud.hidden = YES;
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
