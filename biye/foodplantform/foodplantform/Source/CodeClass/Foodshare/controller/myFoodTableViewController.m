//
//  myFoodTableViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/15.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "myFoodTableViewController.h"
#import "loginViewController.h"
#import "uploadFoodViewController.h"
#import "loginViewController.h"
#import "myFoodTableViewCell.h"


@interface myFoodTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation myFoodTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    [self.tableView registerClass:[myFoodTableViewCell class] forCellReuseIdentifier:@"cell"];
    if ([regAndLogTool shareTools].loginName == nil) {
        loginViewController *logVc = [[loginViewController alloc]init];
        UINavigationController *logNc = [[UINavigationController alloc]initWithRootViewController:logVc];
        [self.navigationController presentViewController:logNc animated:YES completion:^{
            
        }];
    }
    else
    {
        BmobUser *user = [BmobUser getCurrentUser];
        NSString *name = [NSString string];
        name = user.mobilePhoneNumber;
        BmobQuery *query = [BmobQuery queryWithClassName:@"food_message"];
        [query whereKey:@"phone" equalTo:name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                foodModel *fm = [[foodModel alloc]init];
                fm.fid = [obj objectForKey:@"objectId"];
                fm.foodName =[obj objectForKey:@"foodname"];
                fm.foodDes =[obj objectForKey:@"fooddes"];
                fm.address =[obj objectForKey:@"address"];
                fm.rec =[obj objectForKey: @"rec"];
                fm.sty =[obj objectForKey:@"sty"] ;
                fm.score =[obj objectForKey:@"score"] ;
                fm.userName  =[obj objectForKey:@"username"];
                fm.picUrl = [obj objectForKey:@"picurl"];
                fm.cityName = [obj objectForKey:@"city"];
                [self.dataArr addObject:fm];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        
    }
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)rightAction
{
    if ([regAndLogTool shareTools].loginName == nil) {
        loginViewController *loginVc = [[loginViewController alloc]init];
        UINavigationController *loginNc = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self.navigationController presentViewController:loginNc animated:YES completion:^{
            
        }];
        
    }
    else
    {
        uploadFoodViewController *upVc = [[uploadFoodViewController alloc]init];
        [self.navigationController pushViewController:upVc animated:YES];
    }
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
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    myFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    foodModel *myFood = [[foodModel alloc]init];
    myFood = self.dataArr[indexPath.row];
    
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:myFood.picUrl]];
    cell.foodName.text = myFood.foodName;
    NSLog(@"%@",myFood.fid);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    foodModel *fm = self.dataArr[indexPath.row];
    BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:@"food_message" objectId:fm.fid];
    [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [[regAndLogTool shareTools] messageShowWith:@"删除成功" cancelStr:@"确定"];
        }
        else
        {
            NSLog(@"%@",error);
        }
        
        
    }];
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
