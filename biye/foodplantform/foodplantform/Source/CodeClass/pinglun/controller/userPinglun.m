//
//  userPinglun.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/19.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "userPinglun.h"
#import "pinglunView.h"


@interface userPinglun ()
@property(nonatomic,strong) pinglunView *pv;
@property(nonatomic,assign) CGFloat starStr;
@property(nonatomic,strong) MBProgressHUD *hud;
@property(nonatomic,assign) CGFloat userScore;
@property(nonatomic,assign) NSInteger num;
@end

@implementation userPinglun

-(void)loadView
{
    self.pv = [[pinglunView alloc]init];
    self.view = _pv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加星星点击事件
    [self.pv.star addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pv.sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    self.userScore = 0;
    self.num = 0;

    // Do any additional setup after loading the view.
}
-(void)starAction:(HCSStarRatingView *)sender
{
    //self.starStr = [NSMutableString stringWithFormat:@"%0.1f",sender.value];
    self.starStr = sender.value;
    NSLog(@"%.1f",sender.value);
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
-(void)sureAction
{
    if ([self.pv.pinglun.text isEqualToString:@""]) {
        [[regAndLogTool shareTools] messageShowWith:@"请输入评论内容" cancelStr:@"确定"];
        return;
    }
    else
    {
        [self p_setupProgressHud];
        BmobUser *user = [BmobUser getCurrentUser];
        BmobObject *obj = [BmobObject objectWithClassName:@"userpinglun"];
        [obj setObject:self.rec_userid forKey:@"rec_userid"];
        //[obj setObject:@"27853dd567" forKey:@"rec_userid"];
        [obj setObject:user.objectId forKey:@"userid"];
        [obj setObject:self.pv.pinglun.text forKey:@"content"];
        [obj setObject:user.username forKey:@"username"];
        [obj setObject:[NSNumber numberWithFloat:self.starStr] forKey:@"star"];
        [obj setObject:self.orderid forKey:@"orderid"];
        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [[regAndLogTool shareTools] messageShowWith:@"评论成功" cancelStr:@"确定"];
                self.hud.hidden = YES;
                BmobQuery *query = [BmobQuery queryWithClassName:@"userpinglun"];
                [query whereKey:@"rec_userid" equalTo:self.rec_userid];
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    for (BmobObject *obj in array) {
                        self.userScore += [[obj objectForKey:@"star"] floatValue];
                        self.num+=1;
                    }
                    self.userScore = self.userScore/self.num;
                    BmobQuery *foodquery = [BmobQuery queryWithClassName:@"food_message"];
                    [foodquery whereKey:@"userid" equalTo:self.rec_userid];
                    [foodquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        
                        BmobObject *foodObj = array[0];
                        [foodObj setObject:[NSString stringWithFormat:@"%0.1f",self.userScore] forKey:@"userscore"];
                        [foodObj updateInBackground];
                        
                    }];
                }];
                
            }
            else
            {
                NSLog(@"%@",error);
            }
        }];
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
