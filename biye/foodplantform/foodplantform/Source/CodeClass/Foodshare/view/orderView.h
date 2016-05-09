//
//  orderView.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *foodName;
@property(nonatomic,strong)UILabel *fooddes;
@property(nonatomic,strong)UILabel *sty;
@property(nonatomic,strong)UILabel *rec;
@property(nonatomic,strong)UILabel *count;
@property(nonatomic,strong)UIButton *add;
@property(nonatomic,strong)UIButton *sub;
@property(nonatomic,strong)UILabel *resultLabel;
@property(nonatomic,strong)UILabel *resultName;
@property(nonatomic,strong)UILabel *resultNum;
@property(nonatomic,strong)UIButton *sure;

@end
