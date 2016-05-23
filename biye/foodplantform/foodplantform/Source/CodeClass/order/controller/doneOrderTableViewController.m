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
#import "FoodListModel.h"
#import "PindanPesVC.h"
#import "UserApplyListModel.h"
#import "pinglunController.h"
#import "replyTableViewController.h"
#import "allpinglunViewController.h"
#import "userPinglun.h"
# import "PinlunPesVC.h"

@interface doneOrderTableViewController ()<OrderCelllDelegate,BmobEventDelegate>
@property (nonatomic,strong)NSMutableArray *orderDataArr;
@property (nonatomic,strong)NSMutableArray *noHandelOrderArr;
@property (nonatomic,strong)BmobEvent *bmobEvent;
@property (nonatomic,strong)BmobQuery   *userOrderQuery;
@property (nonatomic,strong)BmobQuery   *userFoodQuery;

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
    _userFoodQuery = [BmobQuery queryWithClassName:@"food_message"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 150+10;
     [self.tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
    [self loadDataArr];
    [self listen];
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
         if (_orderOrFoodType.integerValue == 0)//Order表 已发布
         {
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
         }else if (_orderOrFoodType.integerValue == 1)//Food表 已发布
        {
            //queryArr =[[NSArray alloc] initWithObjects:@{@"username":bUser.username}, nil];
            [_userFoodQuery whereKey:@"username" equalTo:bUser.username];
            //[_userFoodQuery addTheConstraintByAndOperationWithArray:queryArr];
            
            [_userFoodQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                [_orderDataArr removeAllObjects];
                for (BmobObject *obj in array)
                {
                    if (obj) {
                        FoodListModel *model = [[FoodListModel alloc] initWithFoodListBomdModel:obj];
                        [ _orderDataArr addObject:model];
                    }
                }
                [self.tableView reloadData];
                _allOrderHud.hidden = YES;
            }];
        }
    }else if(_orderType.integerValue == 2 ||_orderType.integerValue ==3)
    {
        
        queryArr =[[NSArray alloc] initWithObjects:@{@"sender_userID":bUser.objectId},@{@"sender_OrderType":_orderType},@{@"apply_type":_orderOrFoodType},nil];
        
        [_applyOrderQuery addTheConstraintByAndOperationWithArray:queryArr];

        [_applyOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithUserApplyListBomdModel:obj];
                    [ _orderDataArr addObject:model];
                    
                }
            }
            [self.tableView reloadData];
            _allOrderHud.hidden = YES;
        }];
        
    }else if(_orderType.integerValue == 5 ||_orderType.integerValue ==4)
    {
        queryArr =[[NSArray alloc] initWithObjects:@{@"apply_userID":bUser.objectId},@{@"apply_orderType":_orderType},@{@"apply_type":_orderOrFoodType},nil];
        [_applyOrderQuery addTheConstraintByAndOperationWithArray:queryArr];

        [_applyOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithUserApplyListBomdModel:obj];
                    [ _orderDataArr addObject:model];
                }
            }
            NSLog(@"_orderDataArr----------%lu",(unsigned long)_orderDataArr.count);

            [self.tableView reloadData];
            _allOrderHud.hidden = YES;
        }];
    }else if(_orderType.integerValue == 1) //已完成订单  去评价
    {
        queryArr =[[NSArray alloc] initWithObjects:@{@"sender_userID":bUser.objectId},@{@"sender_OrderType":_orderType},@{@"apply_type":_orderOrFoodType},nil];
        BmobQuery * _senderOrderQuery = [BmobQuery queryWithClassName:@"user_apply"];
        [_senderOrderQuery addTheConstraintByAndOperationWithArray:queryArr];
        [_senderOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [_orderDataArr removeAllObjects];
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithUserApplyListBomdModel:obj];
                    [ _orderDataArr addObject:model];
                    
                }
            }
        }];
        BmobQuery * _applyedOrderQuery = [BmobQuery queryWithClassName:@"user_apply"];
        queryArr =[[NSArray alloc] initWithObjects:@{@"apply_userID":bUser.objectId},@{@"apply_orderType":_orderType},@{@"apply_type":_orderOrFoodType},nil];
        [_applyedOrderQuery addTheConstraintByAndOperationWithArray:queryArr];
        
        [_applyedOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array)
            {
                if (obj) {
                    UserApplyListModel *model = [[UserApplyListModel alloc] initWithUserApplyListBomdModel:obj];
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
    
    return _orderDataArr.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell"];
        
    }
    cell.vcOrderType = _orderType;
    if (_orderType.integerValue ==0 &&_orderOrFoodType.integerValue==1) {
        cell.foodListModel = _orderDataArr[indexPath.row];
    }else
    {
        cell.model = _orderDataArr[indexPath.row];
    }
    
    cell.vcOrderOrFoodType = _orderOrFoodType;
    
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
#pragma mark - 拼单表的处理方法
//处理拼单时间 order 表中 0
- (void)handleOrderCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel
{
    
    //修改状态 之后重新加载数据
    if (_orderType.integerValue == 2)//处理的订单
    {
        BmobObject  *user_apply = [BmobObject objectWithoutDatatWithClassName:@"user_apply" objectId:model.applyListobjectId];
        [user_apply setObject:@"3" forKey:@"sender_OrderType"];
        [user_apply setObject:@"5" forKey:@"apply_orderType"];
        [user_apply updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful)
            {
                BmobQuery *userquery = [BmobQuery queryForUser];
                [userquery whereKey:@"objectId" equalTo:model.applyUserListID];
                [userquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    BmobObject *obj = array[0];
                    BmobPush *push = [BmobPush push];
                    BmobQuery *query = [BmobInstallation query];
                    [query whereKey:@"deviceToken" equalTo:[obj objectForKey:@"deviceToken"]];
                    [push setQuery:query];
                    [push setMessage:@"你有订单已经审核了"];
                    [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                        NSLog(@"error %@",[error description]);
                    }];
                }];
               

            }
            [[regAndLogTool shareTools]  messageShowWith:@"已审核" cancelStr:@"确定"];
            [self loadDataArr];
        }];
       
    }else if(_orderType.integerValue == 3)// 点击完成事件
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
                       
                       BmobPush *push = [BmobPush push];
                       BmobQuery *query = [BmobInstallation query];
                       [query whereKey:@"deviceToken" equalTo:[obj objectForKey:@"deviceToken"]];
                       [push setQuery:query];
                       [push setMessage:@"已完成就餐"];
                       [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                           NSLog(@"error %@",[error description]);
                       }];
                   }
                  
               }
           }];
          BmobObjectsBatch    *updateOrderList = [[BmobObjectsBatch alloc] init] ;
          //在GameScore表中创建一条数据
          //在GameScore表中更新objectId为27eabbcfec的数据 @{@"apply_orderType":_orderType}
          [updateOrderList updateBmobObjectWithClassName:@"user_order" objectId:handeledModel.orderID parameters:@{@"order_Type": @"1"}];
          //在GameScore表中删除objectId为30752bb92f的数据
          //[batch deleteBmobObjectWithClassName:@"GameScore" objectId:@"30752bb92f"];
          [updateOrderList batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//              NSLog(@"batch error %@",[error description]);
          }];
          //在oldOrder表中创建一条数据
          BmobUser *bUser = [BmobUser getCurrentUser];
          
          BmobObject *user_oldorder = [BmobObject objectWithClassName:@"user_oldorder"];
          [user_oldorder setObject:handeledModel.userImgeUrl forKey:@"user_headUrl"];
          [user_oldorder setObject: handeledModel.orderPrice forKey:@"order_Price"];
          [user_oldorder setObject:handeledModel.niCheng forKey:@"order_userName"];
          [user_oldorder setObject:@"1" forKey:@"order_Type"];
          [user_oldorder setObject:bUser.objectId forKey:@"order_senderID"];
          [user_oldorder setObject:@(handeledModel.currentPersonNum) forKey:@"order_currentNum"];
          [user_oldorder setObject:@(handeledModel.personMaxNum)forKey:@"order_maxNum"];
          [user_oldorder setObject:handeledModel.name forKey:@"order_name"];
          
          [user_oldorder setObject:handeledModel.target  forKey:@"order_target"];
          
          [user_oldorder setObject:handeledModel.timeDate forKey:@"order_time"];
          [user_oldorder setObject:handeledModel.foodLocation forKey:@"order_locationStr"];
          
          //[user_oldorder setObject:handeledModel. forKey:@"order_loaction"];
          [user_oldorder setObject:handeledModel.foodPayType forKey:@"order_payType"];
          
          // [user_order setObject:@78 forKey:@"score"];
          [user_oldorder saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
              //添加到oldOrder 表
          }];
       }
    if (_orderType.integerValue == 1)//评论
    {
        BmobUser *user = [BmobUser getCurrentUser];
        if ([user.objectId isEqualToString:handeledModel.senderID]) {
            replyTableViewController *reply = [[replyTableViewController alloc]init];
            reply.dataArr = handeledModel.applyUserIDArr;
            
            [_vc.navigationController pushViewController:reply animated:YES];
        }
        else
        {
            allpinglunViewController *allVc = [[allpinglunViewController alloc]init];
            allVc.ordid = handeledModel.orderID;
            allVc.rec_userid =handeledModel.senderID;
//            pinglunController *vc=  [[pinglunController alloc] init];
//            vc.ordID = handeledModel.orderID;
//            userPinglun *userVc = [[userPinglun alloc]init];
//            userVc.rec_userid = handeledModel.senderID;
//            userVc.orderid = handeledModel.orderID;
            [_vc.navigationController pushViewController:allVc animated:YES];
        }
        
    }

}
//处理拼单时间 order  不同意 拼单
- (void)ChatOrderCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel
{
    //修改状态 之后重新加载数据
    if (_orderType.integerValue == 2)//不同意的订单
    {
        BmobObject *bmobObject = [BmobObject objectWithoutDatatWithClassName:@"user_apply"  objectId:model.applyListobjectId];
        [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //删除成功后的动作
                NSLog(@"successful");
                BmobObject *deleteUserOrder = [BmobObject objectWithoutDatatWithClassName:@"user_order" objectId:handeledModel.orderID];
                [deleteUserOrder decrementKey:@"order_currentNum"];
                [deleteUserOrder removeObjectsInArray:@[model.applyUserListID] forKey:@"apply_userIDArr"];
                [deleteUserOrder updateInBackground];
                //人数-1
               
                [self loadDataArr];
            } else if (error){
                NSLog(@"%@",error);
            } else {
                NSLog(@"UnKnow error");
            }
        }];
    }
    //修改状态 之后重新加载数据
    if (_orderType.integerValue == 3) //群聊
    {
        
    }
}
//查看对申请人的历史评论
- (void)showPinlunCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel
{
    PinlunPesVC *vc  =[[PinlunPesVC alloc] init];
    vc.title = [NSString stringWithFormat:@"%@的历史完成订单",model.applyUserListName];
    vc.userID = model.applyUserListID;
    [_vc.navigationController pushViewController:vc animated:YES];
    
}
//加好友
- (void)AddFriendPinlunCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(BmobOrderModel *)handeledModel
{
    
}

#pragma mark -  美食表的处理方法
// 评论 同意 已完成
- (void)handleFoodCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(FoodListModel *)handeledModel
{
    //修改状态 之后重新加载数据
    if (_orderType.integerValue == 2)//同意的美食
    {
        BmobObject  *user_apply = [BmobObject objectWithoutDatatWithClassName:@"user_apply" objectId:model.applyListobjectId];
        [user_apply setObject:@"3" forKey:@"sender_OrderType"];
        [user_apply setObject:@"5" forKey:@"apply_orderType"];
        [user_apply updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful)
            {
                BmobQuery *userquery = [BmobQuery queryForUser];
                [userquery whereKey:@"objectId" equalTo:model.applyUserListID];
                [userquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    BmobObject *obj = array[0];
                    BmobPush *push = [BmobPush push];
                    BmobQuery *query = [BmobInstallation query];
                    [query whereKey:@"deviceToken" equalTo:[obj objectForKey:@"deviceToken"]];
                    [push setQuery:query];
                    [push setMessage:@"你有美食已经审核了"];
                    [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                        NSLog(@"error %@",[error description]);
                    }];
                }];
                
                [[regAndLogTool shareTools]  messageShowWith:@"已审核" cancelStr:@"确定"];
                [self loadDataArr];
            }
            
        }];
    }
    if (_orderType.integerValue == 1)//评论
    {
        BmobUser *user = [BmobUser getCurrentUser];
        if ([user.objectId isEqualToString:handeledModel.senderID]) {
            replyTableViewController *reply = [[replyTableViewController alloc]init];
            reply.dataArr = handeledModel.applyUserIDArr;
            
            [_vc.navigationController pushViewController:reply animated:YES];
        }
        else
        {
            allpinglunViewController *allVc = [[allpinglunViewController alloc]init];
            allVc.ordid = handeledModel.fid;
            allVc.rec_userid =handeledModel.senderFoodUserID;

            [_vc.navigationController pushViewController:allVc animated:YES];
        }
        
    }
     if (_orderType.integerValue == 5)//已完成
     {
         BmobObjectsBatch    *batch = [[BmobObjectsBatch alloc] init] ;
         //在GameScore表中创建一条数据
         //在GameScore表中更新objectId为27eabbcfec的数据 @{@"apply_orderType":_orderType}
         [batch updateBmobObjectWithClassName:@"user_apply" objectId:model.applyListobjectId parameters:@{@"apply_orderType": @"1",@"sender_OrderType": @"1"}];
         //在GameScore表中删除objectId为30752bb92f的数据
         //[batch deleteBmobObjectWithClassName:@"GameScore" objectId:@"30752bb92f"];
         [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
             NSLog(@"batch error %@",[error description]);
         }];
     }
}
//不同意food
 - (void)noAgreeFoodCell:(OrderCell *)cell model:(UserApplyListModel *)model handeledModel:(FoodListModel *)handeledModel
{
    BmobObject *bmobObject = [BmobObject objectWithoutDatatWithClassName:@"user_apply"  objectId:model.applyListobjectId];
    [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [[regAndLogTool shareTools]  messageShowWith:@"已审核" cancelStr:@"确定"];
            [self loadDataArr];
        }
    } ];
}
#pragma mark -  监听user_apply表的变化

-(void)listen{
    //创建BmobEvent对象
    _bmobEvent          = [BmobEvent defaultBmobEvent];
    //设置代理
    _bmobEvent.delegate = self;
    //启动连接
    [_bmobEvent start];
}
//在代理的函数，进行操作

//可以进行监听或者取消监听事件
-(void)bmobEventCanStartListen:(BmobEvent *)event{
    //监听Post表更新
    [_bmobEvent listenTableChange:BmobActionTypeUpdateTable tableName:@"user_apply"];
}
//接收到得数据
-(void)bmobEvent:(BmobEvent *)event didReceiveMessage:(NSString *)message{
    //打印数据
    //NSLog(@"didReceiveMessage:%@",message);
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
