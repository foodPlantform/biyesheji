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


@interface mineTableViewController ()
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
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        personTableViewCell *pCell =  [tableView dequeueReusableCellWithIdentifier:@"pCell"];
        
        // 去掉点击时候的灰色
        pCell.selectionStyle = UITableViewCellSelectionStyleNone;
        pCell.picture.image = [UIImage imageNamed:@"我的1"];
        // 给imageview添加点击手势
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [pCell.picture addGestureRecognizer:_tap];
        pCell.picture.userInteractionEnabled = YES;
        return pCell;
    }
    else
    {
      
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"上传美食";
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.textLabel.text = @"我的订单";
        }
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.textLabel.text = @"设置";
        }
        
        
        return cell;

    }
}
// 点击imageview的事件
-(void)tapAction
{
    loginViewController *loginVc = [[loginViewController alloc]init];
    UINavigationController *loginNc = [[UINavigationController alloc]initWithRootViewController:loginVc];
    [self.navigationController presentViewController:loginNc animated:YES completion:^{
        
    }];
    
}
// 点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        uploadFoodViewController *upVc = [[uploadFoodViewController alloc]init];
        [self.navigationController pushViewController:upVc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        orderViewController *ordVc = [[orderViewController alloc]init];
        [self.navigationController pushViewController:ordVc animated:YES];
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
