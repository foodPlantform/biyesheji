//
//  orderFoodViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "orderFoodViewController.h"
#import "orderView.h"
@interface orderFoodViewController ()
@property(nonatomic,strong)orderView *ov;
@property(nonatomic,assign)NSInteger num;
@end

@implementation orderFoodViewController
-(void)loadView
{
    self.ov = [[orderView alloc]init];
    self.view = _ov;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_data];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.ov.add addTarget:self action:@selector(addNumAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ov.sub addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    self.ov.resultName.text = self.foodmodel_ord.foodName;
    self.num = 0;
    // Do any additional setup after loading the view.
}
-(void)addNumAction
{
    if (self.num<0) {
        return;
    }
    else
    {
        self.num+=1;
        self.ov.count.text  = [NSString stringWithFormat:@"%ld",(long)self.num];
        self.ov.resultNum.text = [NSString stringWithFormat:@"%ld份",(long)self.num];
    }
}
-(void)subAction
{
    if (self.num<=0) {
        return;
    }
    else
    {
        self.num-=1;
        self.ov.count.text = [NSString stringWithFormat:@"%ld",(long)self.num];
        self.ov.resultNum.text = [NSString stringWithFormat:@"%ld份",(long)self.num];
    }
}
-(void)p_data
{
    self.ov.foodName.text = self.foodmodel_ord.foodName;
    self.ov.fooddes.text = self.foodmodel_ord.foodDes;
    self.ov.rec.text = self.foodmodel_ord.rec;
    self.ov.sty.text = self.foodmodel_ord.sty;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
