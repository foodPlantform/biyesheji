//
//  loadupFoodView.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadupFoodView : UIView
@property(nonatomic,strong)UITextField *foodName;
@property(nonatomic,strong)UITextField *address;
@property(nonatomic,strong)UITextField *foodDes;
@property(nonatomic,strong)UIButton *imgBtn;
@property(nonatomic,strong)UIButton *chooseRec;
@property(nonatomic,strong)UIButton *chooseSty;
@property(nonatomic,strong)UIImageView *picture;
@property(nonatomic,strong)UILabel *rec;
@property(nonatomic,strong)UILabel *sty;
@end
