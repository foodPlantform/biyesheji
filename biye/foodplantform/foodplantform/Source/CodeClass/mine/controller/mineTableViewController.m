//
//  mineTableViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "mineTableViewController.h"
#import "personTableViewCell.h"
#import "uploadFoodViewController.h"
#import "loginViewController.h"
#import "orderViewController.h"
#import "userViewController.h"
#import "upListTableViewController.h"
#import "myFoodTableViewController.h"
#import "pinglunController.h"
#import "allpinglunViewController.h"

@interface mineTableViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@end

@implementation mineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[personTableViewCell class] forCellReuseIdentifier:@"pCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        personTableViewCell *pCell =  [tableView dequeueReusableCellWithIdentifier:@"pCell"];
        
        // 去掉点击时候的灰色
        pCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //pCell.picture.image = [UIImage imageNamed:@"我的1"];
        // 给imageview添加点击手势
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [pCell.picture addGestureRecognizer:_tap];
        pCell.picture.userInteractionEnabled = YES;
        
        if ([regAndLogTool shareTools].loginName != nil) {

            
            BmobUser *upUser = [BmobUser getCurrentUser];
            [pCell.picture sd_setImageWithURL:[NSURL URLWithString:[upUser objectForKey:@"head_img"]]];
            
        }
        if ([regAndLogTool shareTools].loginName == nil) {
            pCell.picture.image = [UIImage imageNamed:@"我的1"];
        }
        return pCell;
    }
    else
    {
      
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"我的美食";
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.textLabel.text = @"我的订单";
        }
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.textLabel.text = @"我的信息";
        }
        if (indexPath.section == 0 && indexPath.row == 4) {
            cell.textLabel.text = @"注销登录";
        }
        if (indexPath.section == 0 && indexPath.row == 5) {
            cell.textLabel.text  = @"清除缓存";
        }
        
        
        return cell;

    }
}
// 点击imageview的事件
-(void)tapAction
{
    if ([regAndLogTool shareTools].loginName != nil) {
        BmobUser *user = [BmobUser getCurrentUser];
        NSLog(@"%@",user.username);
        NSLog(@"##%@",[regAndLogTool shareTools].loginName);
    }
    else
    {
        loginViewController *loginVc = [[loginViewController alloc]init];
        UINavigationController *loginNc = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self.navigationController presentViewController:loginNc animated:YES completion:^{
            
        }];

    }
    
    
    
    
}
// 点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        myFoodTableViewController *myVC = [[myFoodTableViewController alloc]init];
        myVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myVC animated:YES];
        
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        orderViewController *ordVc = [[orderViewController alloc]init];
        [self.navigationController pushViewController:ordVc animated:YES];
    }
    if (indexPath.row == 3 && indexPath.section == 0) {
        userViewController *userVc = [[userViewController alloc]init];
        userVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userVc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row ==4) {
        [self regAction];
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要清除缓存吗?" message:@"将清除本地缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.delegate = self;
        alert.tag = 103;
        [alert show];    }
}
-(void)regAction
{
    if ([regAndLogTool shareTools].loginName == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 101;
        alert.delegate = self;
        [alert show];
        return;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要注销吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 102;
        alert.delegate =self;
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 102 && buttonIndex == 1) {
        [BmobUser logout];
        [[regAndLogTool shareTools] setValue:nil forKey:@"loginName"];
        [self.tableView reloadData];
        [[regAndLogTool shareTools] messageShowWith:@"注销成功" cancelStr:@"确定"];
    }
    if (alertView.tag == 103 && buttonIndex == 1) {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"已清除缓存!" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //删除
        [manager removeItemAtPath:cachesPath error:nil];
        
        a.tag = 104;
        [a show];
    }
}

// 返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 &&indexPath.row == 0) {
        return kScreenWidth/3.0+20;
    }
    else
    {
        return 50;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
