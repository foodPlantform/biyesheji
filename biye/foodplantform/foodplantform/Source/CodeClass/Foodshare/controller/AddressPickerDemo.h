//
//  AddressPickerDemo.h
//  BAddressPickerDemo
//
//  Created by 林洁 on 16/1/13.
//  Copyright © 2016年 onlylin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cityName)(NSString *cityname);

@interface AddressPickerDemo : UIViewController
@property(nonatomic,strong)cityName cn;
@property(nonatomic,strong)NSMutableString *cityStr;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com