//
//  foodlistTableViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/20.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "foodlistTableViewController.h"
#import "foodlistTableViewCell.h"
#import "loginViewController.h"
@interface foodlistTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation foodlistTableViewController
// 第三方小菊花
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[foodlistTableViewCell class] forCellReuseIdentifier:@"cell"];

    self.dataArr = [NSMutableArray array];
    [self p_setupProgressHud];
    [[uploadTool shareTool] getuploadDataWithPassValue:^(NSArray *upArr) {
        self.dataArr = upArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            self.hud.hidden = YES;
        });
    }];
    
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
    foodlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    foodModel *fm = [[foodModel alloc]init];
    fm = self.dataArr[indexPath.row];
    [cell.foodPic sd_setImageWithURL:[NSURL URLWithString:fm.picUrl]];
    NSLog(@"%@",fm.picUrl);
    cell.foodName.text = fm.foodName;
    NSLog(@"%@",fm.foodName);
    
    cell.starScore.value  = 3;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



// cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    loginViewController *logVc = [[loginViewController alloc]init];
    UINavigationController *logNc =  [[UINavigationController alloc]initWithRootViewController:logVc];
    [self.navigationController presentViewController:logNc  animated:YES completion:^{
        
    }];
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
