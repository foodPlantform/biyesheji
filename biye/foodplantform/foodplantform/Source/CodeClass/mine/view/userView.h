//
//  userView.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userView : UIView
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *headimg;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UILabel *genderLabel;
@property(nonatomic,strong)UITextField *gender;
@property(nonatomic,strong)UIButton *sure;
@end
