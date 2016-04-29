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

#import "SendPindanVC.h"

#import "PinDanCell.h"
@interface PinDanVcr ()<LrdOutputViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@end

@implementation PinDanVcr

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    NSLog(@"定位成功");
//    CLLocation *location=[locations firstObject];//取出第一个位置
//    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
//    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
//    CLGeocoder *rev = [[CLGeocoder alloc] init];
//    [rev reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (error||placemarks.count==0)
//        {
//            
//        }else
//        {
//            //显示最前面的地标信息
//            CLPlacemark *firstPlacemark=[placemarks firstObject];
//            //显示最前面的地标信息
//            NSLog(@"firstPlacemark.name----------%@",firstPlacemark.name);
//            //经纬度
//            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
//            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
//            
//            NSLog(@"firstPlacemark.name----------%.2f",latitude);
//
//            NSLog(@"firstPlacemark.name----------%.2f",longitude);
//
//        }
// 
//    }];
    //如果不需要实时定位，使用完即使关闭定位服务
    [locationManager stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    NSLog(@"定位失败:%@",error);

}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
    
    
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
     LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"时间⬆️",@"时间⬇️",@"只约异性",@"人数⬆️",@"人数⬇️",@"附近"] origin:CGPointMake(x, y) width:125 height:44 direction:kLrdOutputViewDirectionRight];
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
