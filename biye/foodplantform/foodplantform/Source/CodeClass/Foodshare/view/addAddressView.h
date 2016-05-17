//
//  addAddressView.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addAddressView : UIView
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *chooseCity;
@property(nonatomic,strong)UILabel *cityLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UITextField *name;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UITextField *address;
@property(nonatomic,strong)UIButton *sure;
@end
