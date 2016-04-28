//
//  PinDanVcr.m
//  foodplantform
//
//  Created by 仇亚利 on 16/4/21.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "PinDanVcr.h"
#import "LrdOutputView.h"

#import "SendPindanVC.h"

#import "PinDanCell.h"
@interface PinDanVcr ()<LrdOutputViewDelegate>

@end

@implementation PinDanVcr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemBtnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"发布拼单" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemBtnAction)];
    self.navigationItem.leftBarButtonItem = leftItem;

    [self.tableView registerClass:[PinDanCell class] forCellReuseIdentifier:@"PinDanCell"];
    self.tableView.rowHeight = 260+10;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 筛选 按钮
- (void)leftItemBtnAction
{
    SendPindanVC *sendPindanVc = [[SendPindanVC alloc] init];
    [self.navigationController pushViewController:sendPindanVc animated:YES];

}
#pragma mark - 筛选 按钮
- (void)rightItemBtnAction
{
//    if (btn.tag == 11) {
//        CGFloat x = btn.center.x;
//        CGFloat y = btn.frame.origin.y + btn.bounds.size.height + 10;
//        
//        _outputView = [[LrdOutputView alloc] initWithDataArray:self.dataArr origin:CGPointMake(x, y) width:125 height:44 direction:kLrdOutputViewDirectionLeft];
//    }else {
//        
//    }
    CGFloat x = kScreenWidth-30;
    CGFloat y = 44 + 10;
     LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"时间⬆️",@"时间⬇️",@"只约异性",@"人数"] origin:CGPointMake(x, y) width:125 height:44 direction:kLrdOutputViewDirectionRight];
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        //2_outputView = nil;
    };
    [_outputView pop];

}
#pragma mark - LrdOutputViewDelegate

- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择第%ld行",(long)indexPath.row);
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
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PinDanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PinDanCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.textLabel.text = @"测试";
    // Configure the cell...
    
    return cell;
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
