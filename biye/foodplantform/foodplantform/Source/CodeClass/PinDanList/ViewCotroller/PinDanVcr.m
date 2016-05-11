//
//  PinDanVcr.m
//  foodplantform
//
//  Created by 仇亚利 on 16/4/21.
//  Copyright © 2016年 马文豪. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "PinDanVcr.h"
#import "LrdOutputView.h"
#import "BmobOrderModel.h"
#import "SendPindanVC.h"
#import "CLAlertView.h"
#import "MJRefresh.h"
#import "PindanPesVC.h"
#import "PinDanCell.h"
#define OnceLoadPageRow 5

@interface PinDanVcr ()<LrdOutputViewDelegate,CLLocationManagerDelegate,CLAlertViewDelegate,PindanCelllDelegate>
{
    CLLocationManager *locationManager;
    
    NSMutableArray *_orderArr;
    
    BmobQuery   *_user_orderQuery;
    BmobGeoPoint  *_currentBmobLocation;
    CLLocation  *_currentLocation;
}
@end

@implementation PinDanVcr

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    NSLog(@"定位成功");
    CLLocation *location=[locations firstObject];//取出第一个位置
    _currentLocation = location;
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    CLGeocoder *rev = [[CLGeocoder alloc] init];
    [rev reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error||placemarks.count==0)
        {
            
        }else
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //显示最前面的地标信息
            NSLog(@"firstPlacemark.name----------%@",firstPlacemark.name);
            //经纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            
            NSLog(@"firstPlacemark.name----------%.2f",latitude);

            NSLog(@"firstPlacemark.name----------%.2f",longitude);
            _currentBmobLocation= [[BmobGeoPoint alloc] initWithLongitude:longitude WithLatitude:latitude];
        }
 
    }];
    //如果不需要实时定位，使用完即使关闭定位服务
    [locationManager stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    NSLog(@"定位失败:%@",error);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _orderArr = [[NSMutableArray alloc] initWithCapacity:0];
    //查找user_order表
    _user_orderQuery = [BmobQuery queryWithClassName:@"user_order"];
    _user_orderQuery.limit =OnceLoadPageRow;
    _user_orderQuery.skip = 0;
    //查找user_order表里面里面的所有数据
   [_user_orderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       for (BmobObject *obj in array)
       {
           if (obj) {
               BmobOrderModel *model = [[BmobOrderModel alloc] initWithBomdModel:obj];
               [_orderArr addObject:model];

           }
        }
       [self.tableView reloadData];
   }];
   // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemBtnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"发布拼单" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemBtnAction)];
    self.navigationItem.leftBarButtonItem = leftItem;

    [self.tableView registerClass:[PinDanCell class] forCellReuseIdentifier:@"PinDanCell"];
    self.tableView.rowHeight = 290+10;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
#pragma mark 0.判断用户是否打开定位服务(弹出框)
    [CLLocationManager locationServicesEnabled];//❤️判断用户是否打开位置服务功能
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"用户未打开位置服务功能");
        
        // 1.跳出弹出框，提示用户打开步骤。
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请在设置中打开定位功能" preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        //        }]];
        //        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    // 2.通过代码调到设置页面。openURL:用于app之间的跳转，或跳到iOS允许跳转的页面
    //    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];//❤️通过这个字符串调到程序的设置页面
    //    canOpenURL 判断这个方法是不是可以打开
    //    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    //    }
#pragma mark 1.创建定位管理者对象
    locationManager = [[CLLocationManager alloc]init];
    locationManager.distanceFilter = 10;//❤️设置多少米去更新一次位置信
    locationManager.desiredAccuracy = 2;//❤️设置精准度
#pragma mark 2.info中添加描述使用定位的目的，向用户申请授权
    [locationManager requestAlwaysAuthorization];
#pragma mark 3.挂上代理，实现代理方法
    locationManager.delegate = self;
    
#pragma mark 4.是否使用后台定位服务
    locationManager.allowsBackgroundLocationUpdates = YES;//❤️同时必须在info中设置Required
#pragma mark 5.开始定位
    [locationManager startUpdatingLocation];
    
    
    // 下拉加载 上拉刷新
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //[_mainTableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadNewData
{
    //每页加载多少数据
    _user_orderQuery.limit =OnceLoadPageRow;
    //每页跳过多少数据
    _user_orderQuery.skip = 0;
    
    [_user_orderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"error---------------%@",error);
        [_orderArr removeAllObjects];
        for (BmobObject *obj in array)
        {
            if (obj) {
                BmobOrderModel *model = [[BmobOrderModel alloc] initWithBomdModel:obj];
                [_orderArr addObject:model];
                
            }
        }
        // 2.2秒后刷新表格UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableView reloadData];
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.tableView.mj_header endRefreshing];
        });
        
    }];

    

}
- (void)loadMoreData
{
    //每页加载多少数据
    _user_orderQuery.limit +=OnceLoadPageRow;
    //每页跳过多少数据
    _user_orderQuery.skip += OnceLoadPageRow;
    
    [_user_orderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"error---------------%@",error);
        NSMutableArray *moreDataArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (BmobObject *obj in array)
        {
            if (obj) {
                BmobOrderModel *model = [[BmobOrderModel alloc] initWithBomdModel:obj];
                [moreDataArr addObject:model];
            }
        }
        [_orderArr addObjectsFromArray:moreDataArr];

        
    }];

    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.mj_footer endRefreshing];
    });
}
#pragma mark - 发单 按钮
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
     LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"约会时间",@"约会对象",@"付款方式",@"约会人数",@"附近"] origin:CGPointMake(x, y) width:125 height:44 direction:kLrdOutputViewDirectionRight];
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        //2_outputView = nil;
    };
    [_outputView pop];

}
#pragma mark - LrdOutputViewDelegate 筛选一级类目

- (void)LrdOutputView:(LrdOutputView *)lrdOutputView didSelectedAtIndexPath:(NSIndexPath *)indexPath currentStr:(NSString *)currentStr
{
    
    CLAlertView *bottomView = [CLAlertView globeBottomView];
    bottomView.delegate = self;
    bottomView.hlightButton = 1;
    switch (indexPath.row) {
        case 0://时间
        {
            bottomView.titleArray = @[@"时间⬆️",@"时间⬇️"];
        }
            break;
        case 1://约会对象
        {
            bottomView.titleArray = @[@"不限",@"男",@"女"];
        }
            break;
        case 2://付款方式
        {
            bottomView.titleArray = @[@"我付",@"AA"];
        }
            break;
        case 3://约会人数
        {
            bottomView.titleArray = @[@"人数⬆️",@"人数⬇️",@"2人",@"3人",@"4人",@"5人",@"6人",@"7人",@"8人",@"9人",@"10人"];
        }
            break;
        case 4://附近
        {
            bottomView.titleArray = @[@1,@3,@7,@10,@30,@40,@50,@100,];
            
        }
            break;
            
        default:
            break;
    }
    
    bottomView.lastRow = indexPath.row;
    bottomView.title = currentStr;
    [bottomView show];
    
    
}
#pragma mark - Table view data source
- (void)globeBottomViewButtonClick:(NSInteger)index currentStr:(NSString *)currentStr lastRow:(NSInteger)lastRow titleArr:(NSArray *)titleArr
{
    //_user_orderQuery = [[BmobQuery alloc] initWithClassName:@"user_order"];
   
    
   
    switch (lastRow) {
        case 0://时间
        {
            switch ((long)index) {
                case 0://升序
                {
                    [_user_orderQuery orderByAscending:@"order_time"];
                }
                    break;
                case 1://降序
                {
                    [_user_orderQuery orderByDescending:@"order_time"];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 1://约会对象
        {
            switch ((long)index) {
                case 0://不限
                {
                    [_user_orderQuery whereKey:@"order_target" equalTo:@"0"];
                }
                    break;
                case 1://男
                {
                    [_user_orderQuery whereKey:@"order_target" equalTo:@"1"];

                }
                    break;
                case 2://女6217994910058945074
                {
                    [_user_orderQuery whereKey:@"order_target" equalTo:@"2"];
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 2://付款方式
        {
            switch ((long)index) {
                case 0://我付
                {
                    [_user_orderQuery whereKey:@"order_payType" equalTo:@"0"];
                }
                    break;
                case 1://AA
                {
                    [_user_orderQuery whereKey:@"order_payType" equalTo:@"1"];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3://人数
        {
            switch ((long)index) {
                case 0://升序
                {
                        [_user_orderQuery orderByAscending:@"order_maxNum"];
                }
                    break;
                case 1://降序
                {
                    [_user_orderQuery orderByDescending:@"order_maxNum"];
                }
                    break;
                    
                default:// 按人数人数
                {
                    NSArray *personArray = [currentStr componentsSeparatedByString:@"人"];
                    
                    
                   [_user_orderQuery whereKey:@"order_maxNum" equalTo:[NSNumber numberWithInteger:[personArray[0]integerValue]]];
                }
                    break;
            }
            
        }
            break;
        case 4://附近
        {
            [_user_orderQuery whereKey:@"order_loaction" nearGeoPoint:_currentBmobLocation withinKilometers:[titleArr[lastRow] doubleValue]];
        }
            break;
        default:
            break;
    }
    //每页加载多少数据
    _user_orderQuery.limit =OnceLoadPageRow;
    //每页跳过多少数据
    _user_orderQuery.skip = 0;

    [_user_orderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"error---------------%@",error);
        [_orderArr removeAllObjects];
        for (BmobObject *obj in array)
        {
            if (obj) {
                BmobOrderModel *model = [[BmobOrderModel alloc] initWithBomdModel:obj];
                [_orderArr addObject:model];
                
            }
        }
        [self.tableView reloadData];
        
        
    }];
}

#pragma mark - LrdOutputViewDelegate 筛选二级类目
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _orderArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PindanPesVC *vc=  [[PindanPesVC alloc] init];
    vc.model = _orderArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PinDanCell" ;

    PinDanCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[PinDanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    cell.delegate =self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.currentLocation = _currentLocation;
    cell.model = _orderArr[indexPath.row];
    //cell.textLabel.text = @"测试";
    // Configure the cell...
    
    return cell;
}
#pragma mark - PindanCelllDelegate 加入拼单
-(void)addOrderPinDanCell:(PinDanCell *)cell model:(BmobOrderModel *)model
{
    //注销登陆
  //[BmobUser logout];
    if ([[FileManager shareManager] isUserLogin]) {
        
        //加入拼单
        BmobUser *bUser = [BmobUser getCurrentUser];
        BmobObject *addOrder = [BmobObject objectWithoutDatatWithClassName:@"user_order" objectId:model.orderID];
        if (model.currentPersonNum ==model.personMaxNum) {
            // 1.跳出弹出框，提示用户打开步骤。
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该单已满" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"重新选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }else if ([model.senderID isEqualToString:bUser.objectId])//发单人不能加入该拼单
        {
            // 1.跳出弹出框，提示用户打开步骤。
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你是发单人，不能加入该单" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"重新选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }else
        {
            if ([model.applyUserIDArr containsObject:bUser.objectId])
            {
                // 1.跳出弹出框，提示用户打开步骤。
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你已申请过该拼单" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"重新选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                //订单 申请的人数 及状态 5 通过 4待审核  拼单人的状态
                //订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态
                [addOrder incrementKey:@"order_currentNum"];
                [addOrder setObject:@"4" forKey:@"apply_orderType"];
                [addOrder setObject:@"2" forKey:@"user_orderType"];
                [addOrder addUniqueObjectsFromArray:@[bUser.objectId] forKey:@"apply_userIDArr"];
                [addOrder addUniqueObjectsFromArray:@[@{@"userOrderType":@"5",@"userID":bUser.objectId}] forKey:@"apply_userArr"];
                [addOrder updateInBackground];
                BmobObject *addUserApplyList = [BmobObject objectWithoutDatatWithClassName:@"_User" objectId:bUser.objectId
                                                ];

               
                
                [addUserApplyList addUniqueObjectsFromArray:@[model.orderID] forKey:@"apply_orderListArr" ];
               [addUserApplyList updateInBackground];
                
                 //加到applyOrder表中 便于管理
                BmobObject  *user_applyList = [BmobObject objectWithClassName:@"user_apply"];
                //订单 申请的人数 及状态 5 通过 4待审核  拼单人的状态
                //订单状态 1已完成   2待处理的 3 已处理 发单人的订单状态

                [user_applyList setObject:@"4" forKey:@"apply_orderType"];
                [user_applyList setObject:@"2" forKey:@"sender_OrderType"];
                [user_applyList setObject:bUser.objectId forKey:@"apply_userID"];
                [user_applyList setObject:bUser.username forKey:@"apply_userName"];
                [user_applyList setObject:model.senderID forKey:@"sender_userID"];
                [user_applyList setObject:model.niCheng forKey:@"sender_userName"];

                [user_applyList setObject:model.orderID forKey:@"order_ID"];
                [user_applyList saveInBackground];
                // 1.跳出弹出框，提示用户打开步骤。
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"加入成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self loadNewData];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }

            
            
        }
        

    }else
    {
        [[FileManager shareManager ] LoginWithVc:self];
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
