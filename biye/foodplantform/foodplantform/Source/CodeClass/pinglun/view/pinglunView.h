//
//  pinglunView.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface pinglunView : UIView
@property(nonatomic,strong) UILabel *starLabel;
@property(nonatomic,strong) HCSStarRatingView *star;
@property(nonatomic,strong) UILabel *pinglunLabel;
@property(nonatomic,strong) UITextField *pinglun;
@property(nonatomic,strong) UITextView *pinglunView;
@property(nonatomic,strong) UIButton * sure;
@property(nonatomic,strong) UIScrollView *scrollView;

@end
