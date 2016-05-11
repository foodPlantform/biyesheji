//
//  getCity.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/11.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface getCity : NSObject<CLLocationManagerDelegate>
@property(nonatomic,strong)NSMutableString *cityName;
@property(nonatomic,strong)CLLocationManager *manager;

+(getCity *)shareCity;
-(void)startGetCityName;
@end
