//
//  uploadFoodViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "uploadFoodViewController.h"
#import "loadupFoodView.h"
@interface uploadFoodViewController ()
@property(nonatomic,strong)loadupFoodView *lv;
@end

@implementation uploadFoodViewController

-(void)loadView
{
    self.lv = [[loadupFoodView alloc]init];
    self.view = _lv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
