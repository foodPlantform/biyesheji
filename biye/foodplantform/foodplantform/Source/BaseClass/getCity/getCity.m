//
//  getCity.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/11.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "getCity.h"
#import <CoreLocation/CoreLocation.h>
static getCity *gc;

@implementation getCity
+(getCity *)shareCity
{
    static dispatch_once_t once_token;
    if (gc == nil) {
        dispatch_once(&once_token, ^{
            gc = [[getCity alloc]init];
        });
        
    }
    return gc;
}
-(void)startGetCityName
{
    self.cityName = [NSMutableString string];
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
             self.cityName = placemark.locality;
             
             
             if (!city) {
                 
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 
                 city = placemark.administrativeArea;
                 self.cityName = placemark.administrativeArea;
                 
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

@end
