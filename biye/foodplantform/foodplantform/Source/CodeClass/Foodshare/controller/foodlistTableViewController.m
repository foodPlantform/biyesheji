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
#import "MJRefresh.h"
#import "LrdOutputView.h"
#import "foodDetailController.h"
#import "orderFoodViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface foodlistTableViewController ()<LrdOutputViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)BmobQuery *bQuery;
@property(nonatomic,strong)NSMutableArray *tsArr;// 堂食数组
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLGeocoder *geo;
@property(nonatomic,assign)CLLocationCoordinate2D cood;
@property(nonatomic,strong)NSMutableString *returnCityStr;

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

// 下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //[_mainTableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData
{
    self.bQuery.limit = 10;
    self.bQuery.skip = 0;
    self.dataArr  = [NSMutableArray array];
    [_bQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            foodModel *fm = [[foodModel alloc]init];
            fm.fid = [obj objectForKey:@"objectid"];
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
           self.hud.hidden = YES;
           
           [self.tableView.mj_header endRefreshing];

       });
        
    }];
}
-(void)loadMoreData
{
    self.bQuery.limit = 10;
    self.bQuery.skip += 10;
//    [[uploadTool shareTool] getuploadDataWithPassValue:^(NSArray *upArr) {
//        self.dataArr = upArr;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            self.hud.hidden = YES;
//            [self.tableView.mj_footer endRefreshing];
//        });
//        
//    }];

    [_bQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            foodModel *fm = [[foodModel alloc]init];
            fm.fid = [obj objectForKey:@"objectid"];
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
            self.hud.hidden = YES;
            
            [self.tableView.mj_footer endRefreshing];
            
        });
        
    }];
}


- (void)viewDidLoad {
  
    [super viewDidLoad];
   
    
    UIBarButtonItem *changeCity = [[UIBarButtonItem alloc]initWithTitle:@"切换城市" style:UIBarButtonItemStyleDone target:self action:@selector(changeCityAction)];
    UIBarButtonItem *showCity = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    NSArray *btnArr = [NSArray arrayWithObjects:changeCity,showCity, nil];
    self.navigationItem.leftBarButtonItems = btnArr;
    // 新建一个定位管理类
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    // 向设备请求授权
    if ([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 向设备申请"程序使用中的时候,使用定位功能"
        //[self.manager requestWhenInUseAuthorization];
               //一直都可以定位
                [self.manager requestAlwaysAuthorization];
    }
    // 多少米定位一次
    self.manager.distanceFilter = 10;
    
    //  定位的精度
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
    // 编码和反编码对象初始化
    self.geo = [[CLGeocoder alloc]init];

    [showCity setTitle: [self getCityNameWithCoordinate:self.cood]];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[foodlistTableViewCell class] forCellReuseIdentifier:@"cell"];

    self.dataArr = [NSMutableArray array];
    [self p_setupProgressHud];
    self.bQuery.limit = 10;
    self.bQuery.skip = 0;
    [[uploadTool shareTool] getuploadDataWithPassValue:^(NSArray *upArr) {
        self.dataArr = upArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            self.hud.hidden = YES;
        });
    }];
    [self setupRefresh];
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    self.cood = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    NSLog(@"经度:%f,纬度:%f,海拔:%f,航向:%f,行走速度:%f",location.coordinate.longitude,location.coordinate.latitude,location.altitude,location.course,location.speed);
}
-(NSString *)getCityNameWithCoordinate:(CLLocationCoordinate2D)cood
{
    self.returnCityStr = [NSMutableString string];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:cood.latitude longitude:cood.longitude];
    [self.geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"反编码失败");
            return ;
        }
        CLPlacemark *placemark = [placemarks lastObject];
        [placemark.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSLog(@"%@:%@",key,obj);
            self.returnCityStr  = [obj valueForKey:@"Name"];
        }];
    }];
    return _returnCityStr;
    
}
-(void)changeCityAction
{
    NSLog(@"123");
}

// rightButton
-(void)rightAction
{
    CGFloat x = kScreenWidth-30;
    CGFloat y = 44 + 10;
    LrdOutputView *_outputView = [[LrdOutputView alloc] initWithDataArray:@[@"堂食",@"外卖",@"取消筛选",] origin:CGPointMake(x, y) width:125 height:44 direction:kLrdOutputViewDirectionRight];
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        //2_outputView = nil;
    };
    [_outputView pop];

}
-(void)LrdOutputView:(LrdOutputView *)lrdOutputView didSelectedAtIndexPath:(NSIndexPath *)indexPath currentStr:(NSString *)currentStr
{
    
    if (indexPath.row == 0) {
        [self.dataArr removeAllObjects];
        self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
        [_bQuery whereKey:@"sty" equalTo:@"堂食"];
        [_bQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                foodModel *fm = [[foodModel alloc]init];
                fm.fid = [obj objectForKey:@"objectid"];
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
    if (indexPath.row == 1) {
        [self.dataArr removeAllObjects];
        self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
        [_bQuery whereKey:@"sty" equalTo:@"外卖"];
        [_bQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                foodModel *fm = [[foodModel alloc]init];
                fm.fid = [obj objectForKey:@"objectid"];
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
    if (indexPath.row == 2) {
        self.bQuery.limit = 10;
        self.bQuery.skip = 0;
        [self.dataArr removeAllObjects];
        [[uploadTool shareTool] getuploadDataWithPassValue:^(NSArray *upArr) {
            self.dataArr = upArr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                self.hud.hidden = YES;
            });
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
    cell.addressLabel.text = fm.address;
    cell.sty.text = fm.sty;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}



// cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    foodModel *fm = [[foodModel alloc]init];
    fm = self.dataArr[indexPath.row];

    foodDetailController *foodVc = [[foodDetailController alloc]init];
    foodVc.foodmodel = fm;
    [self.navigationController pushViewController:foodVc  animated:YES];
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
