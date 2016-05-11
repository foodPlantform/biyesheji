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
#import "AddressPickerDemo.h"


@interface foodlistTableViewController ()<LrdOutputViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)BmobQuery *bQuery;
@property(nonatomic,strong)NSMutableArray *tsArr;// 堂食数组
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLGeocoder *geo;
@property(nonatomic,assign)CLLocationCoordinate2D cood;
@property(nonatomic,strong)NSMutableString *returnCityStr;
@property(nonatomic,strong)UIBarButtonItem *showCity;

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
    
    [_bQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.dataArr removeAllObjects];
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
    self.showCity = [[UIBarButtonItem alloc]initWithTitle:self.returnCityStr style:UIBarButtonItemStyleDone target:self action:nil];
    
    NSArray *btnArr = [NSArray arrayWithObjects:changeCity,_showCity, nil];
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

    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[foodlistTableViewCell class] forCellReuseIdentifier:@"cell"];

    self.dataArr = [NSMutableArray array];
    [self p_setupProgressHud];
    self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
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
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //根据经纬度反向地理编译出地址信息
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
    {
        
        if (array.count > 0)
            
        {
            
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //将获得的所有信息显示到label上
            
            NSLog(@"%@",placemark.name);
           
            
            //获取城市
            
            NSString *city = placemark.locality;
            //self.returnCityStr = placemark.locality;
            NSLog(@"city%@",self.returnCityStr);
            
            
            if (!city) {
                
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                
                city = placemark.administrativeArea;
                //self.returnCityStr = placemark.administrativeArea;
                
                
            }
            
            
        }
        
        else if (error == nil && [array count] == 0)
            
        {
            
            NSLog(@"No results were returned.");
            
        }
        
        else if (error != nil)
            
        {
            
            NSLog(@"An error occurred = %@", error);
            
        }
        
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    
    [manager stopUpdatingLocation];
    
}

-(void)changeCityAction
{
    
    AddressPickerDemo *addressPickerDemo = [[AddressPickerDemo alloc] init];
    
    addressPickerDemo.cn = ^(NSString * s)
    {
        self.returnCityStr = s;
        [self.showCity setTitle:s];
        [self.dataArr removeAllObjects];
        self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
        [_bQuery whereKey:@"city" equalTo:s];
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

        
    };
    [self.navigationController pushViewController:addressPickerDemo animated:YES];
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
        if (self.returnCityStr != nil) {
            [self.dataArr removeAllObjects];
            BmobQuery *query2 = [BmobQuery queryWithClassName:@"food_message"];
            [query2 whereKey:@"city" equalTo:_returnCityStr];
            BmobQuery *query1 = [BmobQuery queryWithClassName:@"food_message"];
            [query1 whereKey:@"sty" equalTo:@"堂食"];
            self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
            [_bQuery add:query1];
            [_bQuery add:query2];
            [_bQuery andOperation];
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
        else
        {
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
        
    }
    if (indexPath.row == 1) {
        if (self.returnCityStr!= nil) {
            [self.dataArr removeAllObjects];
            BmobQuery *query2 = [BmobQuery queryWithClassName:@"food_message"];
            [query2 whereKey:@"city" equalTo:_returnCityStr];
            BmobQuery *query1 = [BmobQuery queryWithClassName:@"food_message"];
            [query1 whereKey:@"sty" equalTo:@"外卖"];
            self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
            [_bQuery add:query1];
            [_bQuery add:query2];
            [_bQuery andOperation];
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
        else
        {
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
        
    }
    if (indexPath.row == 2) {
        self.bQuery.limit = 10;
        self.bQuery.skip = 0;
        if (self.returnCityStr != nil) {
            [self.dataArr removeAllObjects];
            self.bQuery = [BmobQuery queryWithClassName:@"food_message"];
            [_bQuery whereKey:@"city" equalTo:_returnCityStr];
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
        else
        {
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
