//
//  doneOrderTableViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/3.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "doneOrderTableViewController.h"
#import "OrderCell.h"
#import "BmobOrderModel.h"
#import "PindanPesVC.h"
#import "UserApplyListModel.h"
@interface doneOrderTableViewController ()<OrderCelllDelegate>
@property (nonatomic,strong)NSMutableArray *orderDataArr;
@property (nonatomic,strong)NSMutableArray *noHandelOrderArr;

@property (nonatomic,strong)BmobQuery   *userOrderQuery;

@property (nonatomic,strong)BmobQuery   *applyOrderQuery;

@end

@implementation doneOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _orderDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    _userOrderQuery = [BmobQuery queryWithClassName:@"user_order"];
    _applyOrderQuery = [BmobQuery queryWithClassName:@"user_apply"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 150+10;
     [self.tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
    [self loadDataArr];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)loadDataArr
{
    //条件语句
    NSArray *queryArr;
    //查找user_order表里面里面的所有数据
    BmobUser *bUser = [BmobUser getCurrentUser];
    //订单 申请的人数 及状态  4待审核 5已审核  拼单人的状态
    //订单状态 1已完成   2待处理的  3已处理 发单人的订单状态
    if (_orderType.integerValue == 0) {
        queryArr =[[NSArray alloc] initWithObjects:@{@"order_senderID":bUser.objectId}, nil];
        [_userOrderQuery addTheConstraintByAndOperationWithArray:queryArr];

        [_userOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    BmobOrderModel *model = [[BmobOrderModel alloc] initWithBomdModel:obj];
                    [ _orderDataArr addObject:model];
                    
                }
            }
            [self.tableView reloadData];
        }];
    }else if(_orderType.integerValue == 2 ||_orderType.integerValue ==3)
    {
        
        queryArr =[[NSArray alloc] initWithObjects:@{@"sender_userID":bUser.objectId},@{@"sender_OrderType":_orderType},nil];
        [_applyOrderQuery addTheConstraintByAndOperationWithArray:queryArr];

        [_applyOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithBomdModel:obj];
                    [ _orderDataArr addObject:model];
                    
                }
            }
            [self.tableView reloadData];
        }];
        
    }else if(_orderType.integerValue == 5 ||_orderType.integerValue ==4)
    {
        queryArr =[[NSArray alloc] initWithObjects:@{@"apply_userID":bUser.objectId},@{@"apply_orderType":_orderType},nil];
        [_applyOrderQuery addTheConstraintByAndOperationWithArray:queryArr];

        [_applyOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithBomdModel:obj];
                    [ _orderDataArr addObject:model];
                }
            }
            NSLog(@"_orderDataArr----------%lu",(unsigned long)_orderDataArr.count);

            [self.tableView reloadData];
        }];
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
//    if (_orderType.integerValue == 0) {
//        return _orderDataArr.count;
//        
//    }else if(_orderType.integerValue == 2 ||_orderType.integerValue ==3)
//    {
//        NSMutableArray *noHandelArr = [[NSMutableArray alloc] initWithCapacity:0];//待处理
//        NSMutableArray *HandeledArr = [[NSMutableArray alloc] initWithCapacity:0];//已处理
//        for(BmobOrderModel *model  in _orderDataArr)
//        {
//            if (model.userOrderTyoe.intValue == 2)
//            {
//                for (ApplyOrderModel *applyModel in model.applyUserAndTypeArr)
//                {
//                    if (applyModel.orderType.intValue == 5) {
//                        [noHandelArr addObject:applyModel];
//                    }else if (applyModel.orderType.intValue == 4 )
//                    {
//                        [noHandelArr addObject:applyModel];
//                    }
//                }
//            }
//        }
//
//    }else
//    {
//        return _orderDataArr.count;
//    }
    
    return _orderDataArr.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell"];
        
    }
    cell.vcOrderType = _orderType;
    cell.delegate =self;
    cell.model = _orderDataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PindanPesVC *vc = [[PindanPesVC alloc] init];
    vc.model = _orderDataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
//处理拼单时间
- (void)handleOrderCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel
{   //修改状态 之后重新加载数据
    BmobObject  *user_apply = [BmobObject objectWithoutDatatWithClassName:@"user_apply" objectId:model.applyListobjectId];
    [user_apply setObject:@"3" forKey:@"sender_OrderType"];
    [user_apply setObject:@"5" forKey:@"apply_orderType"];
    [user_apply updateInBackground];
    [self loadDataArr];
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
