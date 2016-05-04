//
//  KCMainViewController.h
//  MapKit
//
//  Created by Kenshin Cui on 14/3/27.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLPlacemark;
@protocol KCLocationLongPressToDoDelegate <NSObject>

@optional
- (void)KCMainViewControllerLongProessGetLoaction:(NSString*)longPressPlacemarkStr place:(CLPlacemark*)placeMark;

@end

@interface KCMainViewController : UIViewController



@property (assign, nonatomic) id <KCLocationLongPressToDoDelegate> delegate;
@end
