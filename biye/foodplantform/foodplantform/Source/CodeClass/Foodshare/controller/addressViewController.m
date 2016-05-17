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
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *phonenow;
@property(nonatomic,strong)NSString *address;
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
    cell.name.text = am.nickname;
    cell.phone.text = am.phonenow;
    cell.address.text  = am.address;
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
    NSLog(@"%@",self.username);
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
