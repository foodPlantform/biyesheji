//
//  addressViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "addressViewController.h"
#import "addressView.h"
#import "addAddressViewController.h"
#import "recAddressCell.h"
#import "addressModel.h"

@interface addressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)addressView *av;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *username;

@property(nonatomic,strong)NSString *phonenow;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *senderID;
@end

@implementation addressViewController
-(void)loadView
{
    self.av = [[addressView alloc]init];
    self.view = _av;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.av.tableView registerClass:[recAddressCell class] forCellReuseIdentifier:@"cell"];
    self.av.tableView.dataSource = self;
    self.av.tableView.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加地址" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    [self.av.btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.av.btn.enabled = NO;
    BmobUser *user = [BmobUser getCurrentUser];
    
//    self.dataArr = [NSMutableArray array];
//    BmobQuery *query = [BmobQuery queryWithClassName:@"address"];
//    [query whereKey:@"username" equalTo:user.username];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//       
//        for (BmobObject *obj in array) {
//            addressModel *am = [[addressModel alloc]init];
//            am.username = [obj objectForKey:@"username"];
//            am.nickname = [obj objectForKey:@"nickname"];
//            am.phonenow = [obj objectForKey: @"phonenow"];
//            am.address = [obj objectForKey:@"address"];
//            am.phone =  [obj objectForKey:@"phone"];
//            [self.dataArr addObject:am];
//            
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.av.tableView reloadData];
//        });
//    }];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    BmobUser *user = [BmobUser getCurrentUser];
    
    self.dataArr = [NSMutableArray array];
    BmobQuery *query = [BmobQuery queryWithClassName:@"address"];
    [query whereKey:@"username" equalTo:user.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array) {
            addressModel *am = [[addressModel alloc]init];
            am.username = [obj objectForKey:@"username"];
            am.nickname = [obj objectForKey:@"nickname"];
            am.phonenow = [obj objectForKey: @"phonenow"];
            am.address = [obj objectForKey:@"address"];
            am.phone =  [obj objectForKey:@"phone"];

            [self.dataArr addObject:am];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.av.tableView reloadData];
        });
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    recAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30,40, 30, 30)];
    img.image = [UIImage imageNamed:@"check"];
    [cell.selectedBackgroundView addSubview:img];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor greenColor];
    addressModel *am = self.dataArr[indexPath.row];
    
    cell.name.text = [NSString stringWithFormat:@"姓名：%@",am.nickname];
    cell.phone.text = [NSString stringWithFormat:@"电话：%@",am.phonenow];
    cell.address.text  = [NSString stringWithFormat:@"收货地址：%@",am.address];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.av.btn.enabled = YES;
    addressModel *am = [[addressModel alloc]init];
    am = self.dataArr[indexPath.row];
    self.username = am.username;
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)rightAction
{
    addAddressViewController *addVC = [[addAddressViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnAction
{
    BmobUser *user =[BmobUser getCurrentUser];
    BmobObject *user_applyList = [BmobObject objectWithClassName:@"user_apply"];
    //订单 申请的人数 及状态 5 通过 4待审核  拼单人的状态
    //订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
    
    [user_applyList setObject:@"4" forKey:@"apply_orderType"];
    [user_applyList setObject:@"2" forKey:@"sender_OrderType"];
    //0 表示order表 1 food表
    [user_applyList setObject:@"1" forKey:@"apply_type"];
    [user_applyList setObject:user.objectId forKey:@"apply_userID"];
    [user_applyList setObject:user.username forKey:@"apply_userName"];
    [user_applyList setObject:self.foodID forKey:@"order_ID"];
    NSLog(@"phone%@",_fm.phone);
    BmobQuery *query = [BmobQuery queryWithClassName:@"_User"];
    [query whereKey:@"mobilePhoneNumber" equalTo:_fm.phone];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        BmobObject *obj = array[0];
        [user_applyList setObject:[obj objectForKey:@"objectId"] forKey:@"sender_userID"];
        
        [user_applyList setObject:[obj objectForKey:@"username"] forKey:@"sender_userName"];
        self.senderID = [obj objectForKey:@"objectId"];
        
        [user_applyList saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [[regAndLogTool shareTools] messageShowWith:@"预订成功" cancelStr:@"确定"];
                BmobQuery *userquery = [BmobQuery queryForUser];
                [userquery whereKey:@"objectId" equalTo:_senderID];
                
                [userquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    
                    BmobObject *obj = array[0];
                    BmobPush *push = [BmobPush push];
                    BmobQuery *query = [BmobInstallation query];
                    [query whereKey:@"deviceToken" equalTo:[obj objectForKey:@"deviceToken"]];
                    [push setQuery:query];
                    [push setMessage:@"有人申请你的订单了，去看看吧"];
                    [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                        NSLog(@"error %@",[error description]);
                    }];
                }];
                
            }
        }];

        
    }];
    
    

    
   
   
  
    NSLog(@"%@%@",self.foodID, self.username);
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
