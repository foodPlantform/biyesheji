//
//  KCMainViewController.h
//  MapKit
//
//  Created by Kenshin Cui on 14/3/27.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import "KCCalloutAnnotation.h"
#import "KCCalloutAnnotationView.h"
@class CLPlacemark;
@protocol KCLocationLongPressToDoDelegate <NSObject>

@optional
- (void)KCMainViewControllerLongProessGetLoaction:(NSString*)longPressPlacemarkStr WithLongitude:(double)mylongitude   WithLatitude:(double)mylatitude;

@end

@interface KCMainViewController : UIViewController
//搜索地理位置
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,assign)CLLocationCoordinate2D currentCLLocationCoordinate2D ;
@property (assign, nonatomic) id <KCLocationLongPressToDoDelegate> delegate;
@end
