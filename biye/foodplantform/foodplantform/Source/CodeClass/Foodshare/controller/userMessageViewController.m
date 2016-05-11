//
//  userMessageViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "userMessageViewController.h"
#import "userMessageView.h"
@interface userMessageViewController ()
@property(nonatomic,strong)userMessageView *uv;

@property(nonatomic,strong)NSString *phoneStr;
@end

@implementation userMessageViewController
-(void)loadView
{
    self.uv = [[userMessageView alloc]init];
    self.view = _uv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self dataBind];
    
    // Do any additional setup after loading the view.
}
-(void)dataBind
{
    self.uv.userName .text = self.foodmodel_user.userName;
    BmobQuery *query = [BmobQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:self.foodmodel_user.userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        for (BmobObject *obj in array) {
            self.phoneStr = [obj valueForKey:@"mobilePhoneNumber"];
        }
        self.uv.phone.text = _phoneStr;
    }];
    self.uv.address.text = self.foodmodel_user.address;
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
