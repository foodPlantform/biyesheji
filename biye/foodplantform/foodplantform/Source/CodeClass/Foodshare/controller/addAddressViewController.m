//
//  addAddressViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "addAddressViewController.h"
#import "addAddressView.h"
#import <CoreLocation/CoreLocation.h>
#import "AddressPickerDemo.h"


@interface addAddressViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)addAddressView *av;
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLGeocoder *geo;
@property(nonatomic,strong)NSMutableString *cityStr;
@end

@implementation addAddressViewController
-(void)loadView
{
    self.av = [[addAddressView alloc]init];
    self.view = _av;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    [self.av.chooseCity addTarget:self action:@selector(chooseCityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.av.sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)chooseCityAction
{
    AddressPickerDemo *addressPickerDemo = [[AddressPickerDemo alloc] init];
    
    addressPickerDemo.cn = ^(NSString * s)
    {
        self.av.cityLabel.text = s;
    };
    [self.navigationController pushViewController:addressPickerDemo animated:YES];

}
-(void)sureAction
{
    if ([self.av.name.text isEqualToString:@""] || [self.av.phone.text isEqualToString:@""] || [self.av.address.text isEqualToString:@""] || self.av.cityLabel.text == nil) {
        [[regAndLogTool shareTools] messageShowWith:@"请输入完整内容" cancelStr:@"确定"];
    }
    else
    {
        BmobUser *user = [BmobUser getCurrentUser];
        BmobObject *obj = [BmobObject objectWithClassName:@"address"];
        [obj setObject:user.username forKey:@"username"];
        [obj setObject:user.mobilePhoneNumber forKey:@"phone"];
        [obj setObject:self.av.name.text forKey:@"nickname"];
        [obj setObject:self.av.phone.text forKey:@"phonenow"];
        [obj setObject:self.av.address.text forKey:@"address"];
        [obj setObject:self.av.cityLabel.text forKey:@"city"];
        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [[regAndLogTool shareTools] messageShowWith:@"添加成功" cancelStr:@"确定"];
            }
            else
            {
                [[regAndLogTool shareTools] messageShowWith:@"添加失败" cancelStr:@"确定"];
            }
        }];

    }
    
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
             self.av.address.text = placemark.locality;
 
             
             
             if (!city) {
                 
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 
                 city = placemark.administrativeArea;
                 //self.returnCityStr = placemark.administrativeArea;
                 self.av.address.text = placemark.administrativeArea;
                 
                 
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
