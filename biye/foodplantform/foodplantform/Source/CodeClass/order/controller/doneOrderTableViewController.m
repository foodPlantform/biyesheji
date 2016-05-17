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
//已完成的订单  apply表里面的订单 的订单数
@property (nonatomic,assign)NSInteger senderOrderArrNum;

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
    [self setupAllOrderProgressHud];
    _allOrderHud.hidden =YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
// 第三方小菊花
- (void)setupAllOrderProgressHud
{
    self.allOrderHud = [[MBProgressHUD alloc] initWithView:self.view];
    _allOrderHud.frame = self.view.bounds;
    _allOrderHud.minSize = CGSizeMake(100, 100);
    _allOrderHud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_allOrderHud];
    [_allOrderHud show:YES];
}
- (void)loadDataArr
{
    _allOrderHud.hidden = NO;
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
            _allOrderHud.hidden = YES;
        }];
    }else if(_orderType.integerValue == 2 ||_orderType.integerValue ==3)
    {
        
        queryArr =[[NSArray alloc] initWithObjects:@{@"sender_userID":bUser.objectId},@{@"sender_OrderType":_orderType},@{@"apply_type":@"0"},nil];
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
            _allOrderHud.hidden = YES;
        }];
        
    }else if(_orderType.integerValue == 5 ||_orderType.integerValue ==4)
    {
        queryArr =[[NSArray alloc] initWithObjects:@{@"apply_userID":bUser.objectId},@{@"apply_orderType":_orderType},@{@"apply_type":@"0"},nil];
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
            _allOrderHud.hidden = YES;
        }];
    }else if(_orderType.integerValue == 1) //已完成订单  去评价
    {
        queryArr =[[NSArray alloc] initWithObjects:@{@"sender_userID":bUser.objectId},@{@"sender_OrderType":_orderType},@{@"apply_type":@"0"},nil];
        BmobQuery * _senderOrderQuery = [BmobQuery queryWithClassName:@"user_apply"];
        [_senderOrderQuery addTheConstraintByAndOperationWithArray:queryArr];
        [_senderOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithBomdModel:obj];
                    [ _orderDataArr addObject:model];
                    
                }
            }
        }];
        BmobQuery * _applyedOrderQuery = [BmobQuery queryWithClassName:@"user_apply"];
        queryArr =[[NSArray alloc] initWithObjects:@{@"apply_userID":bUser.objectId},@{@"apply_orderType":_orderType},@{@"apply_type":@"0"},nil];
        [_applyedOrderQuery addTheConstraintByAndOperationWithArray:queryArr];
        
        [_applyedOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithBomdModel:obj];
                    [ _orderDataArr addObject:model];
                    
                }
            }
            [self.tableView reloadData];
            _allOrderHud.hidden = YES;
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
    
    cell.model = _orderDataArr[indexPath.row];
   cell.delegate =self;
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
{
    
    //修改状态 之后重新加载数据
    if (_orderType.integerValue == 2)//处理的订单
    {
        BmobObject  *user_apply = [BmobObject objectWithoutDatatWithClassName:@"user_apply" objectId:model.applyListobjectId];
        [user_apply setObject:@"3" forKey:@"sender_OrderType"];
        [user_apply setObject:@"5" forKey:@"apply_orderType"];
        [user_apply updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            [[regAndLogTool shareTools]  messageShowWith:@"已审核" cancelStr:@"确定"];
            [self loadDataArr];
        }];
       
    }else if(_orderType.integerValue == 3)// 组队就餐
      {
         BmobQuery  *    _handelOrderQuery = [BmobQuery queryWithClassName:@"user_apply"];
          //添加user_order是gauge订单的信息
         [_handelOrderQuery whereKey:@"order_ID" equalTo:handeledModel.orderID];
         [_handelOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
               
               for (BmobObject *obj in array)
               {
                   if (obj) {
                       BmobObjectsBatch    *batch = [[BmobObjectsBatch alloc] init] ;
                       //在GameScore表中创建一条数据
                       //在GameScore表中更新objectId为27eabbcfec的数据 @{@"apply_orderType":_orderType}
                       [batch updateBmobObjectWithClassName:@"user_apply" objectId:obj.objectId parameters:@{@"apply_orderType": @"1",@"sender_OrderType": @"1"}];
                       //在GameScore表中删除objectId为30752bb92f的数据
                       //[batch deleteBmobObjectWithClassName:@"GameScore" objectId:@"30752bb92f"];
                       [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                          NSLog(@"batch error %@",[error description]);
                       }];
                   }
                  
               }
           }];
          
          
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
