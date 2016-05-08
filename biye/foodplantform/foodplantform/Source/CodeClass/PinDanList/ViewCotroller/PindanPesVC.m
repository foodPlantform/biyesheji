//
//  PindanPesVC.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/7.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "PindanPesVC.h"
#define PinDanCellJianJu 10

@interface PindanPesVC ()

//用户头像
@property(nonatomic,strong)UIImageView *userImgV;
//昵称
@property(nonatomic,strong)UILabel *userNiChengLB;
@property(nonatomic,strong)UILabel *userSexAgeLB;

//拼单人数
@property(nonatomic,strong)UILabel *foodPersonNumLB;
//拼单食物名字
@property(nonatomic,strong)UILabel *foodNameLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodPayTypeLB;
//拼单对象
@property(nonatomic,strong)UILabel *foodPersonLB;
//拼单时间
@property(nonatomic,strong)UILabel *foodTimeLB;
//拼单地点
@property(nonatomic,strong)UILabel *foodLocationLB;

//拼单地点  距离地点
@property(nonatomic,strong)UILabel *foodKMLB;
// 加入拼单
@property(nonatomic,strong)UIButton *addPindanBtn;


@end

@implementation PindanPesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼单详情";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setPinDanPesView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setPinDanPesView
{
    /*
     @property(nonatomic,strong)UIImageView *userImg;
     @property(nonatomic,strong)UILabel *userNiChengLB;
     @property(nonatomic,strong)UILabel *userSexAgeLB;
     
     @property(nonatomic,strong)UILabel *foodNameLB;
     @property(nonatomic,strong)UILabel *foodTimeLB;
     @property(nonatomic,strong)UILabel *foodLocationLB;
     */
    _userImgV = [[UIImageView alloc]initWithFrame:CGRectMake(PinDanCellJianJu,64+ PinDanCellJianJu, 100, 100) ];
    [self.view addSubview:_userImgV];
    _userImgV.backgroundColor = [UIColor yellowColor];
    
    _userNiChengLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu, CGRectGetMinY(_userImgV.frame), kScreenWidth/3.0, 10)];
    _userNiChengLB.text = [NSString stringWithFormat:@"昵称:  测试昵称"];
    [self.view addSubview:_userNiChengLB];
    
    _userSexAgeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu,  CGRectGetMaxY(_userNiChengLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _userSexAgeLB.text = [NSString stringWithFormat:@"性别／年龄: 测试性别＋年龄"];
    [self.view addSubview:_userSexAgeLB];
    _foodPayTypeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgV.frame)+PinDanCellJianJu,  CGRectGetMaxY(_userSexAgeLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _foodPayTypeLB.text = [NSString stringWithFormat:@"付款方式: 测试"];
    [self.view addSubview:_foodPayTypeLB];
    
    _foodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_userImgV.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _foodNameLB.text = [NSString stringWithFormat:@"   我要吃 :  %@",_model.name] ;
    
    [self.view addSubview:_foodNameLB];
    
    
    _foodPersonLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodNameLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    
    _foodPersonLB.text = [NSString stringWithFormat:@"约吃对象:  测试数据"] ;
    
    [self.view addSubview:_foodPersonLB];
    _foodPersonNumLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodPersonLB.frame)+PinDanCellJianJu*2, kScreenWidth/2.0, 10)];
    _foodPersonNumLB.text = [NSString stringWithFormat:@"约吃人数:  %ld／%ld",(long)_model.currentPersonNum,(long)_model.personMaxNum] ;
    
    [self.view addSubview:_foodPersonNumLB];
    
    
    _addPindanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addPindanBtn.frame = CGRectMake(kScreenWidth -kScreenWidth/5.0-10, CGRectGetMaxY(_foodPersonLB.frame)+PinDanCellJianJu*2, kScreenWidth/5.0, 40);
    [_addPindanBtn setTitle:@"加入拼单" forState:UIControlStateNormal];
   // [_addPindanBtn addTarget:self action:@selector(addPindanBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _addPindanBtn.backgroundColor = [UIColor redColor];
    //[self.view addSubview:_addPindanBtn];
    
    _foodTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodPersonNumLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 10)];
    
    _foodTimeLB.text = [NSString stringWithFormat:@"约吃地点:  %@",_model.timeDateStr] ;

    [self.view addSubview:_foodTimeLB];
    
    _foodLocationLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodTimeLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 60)];
    _foodLocationLB.numberOfLines = 0;
    _foodLocationLB.text = [NSString stringWithFormat:@"约吃地点:  %@",_model.foodLocation] ;
    
    [self.view addSubview:_foodLocationLB];
    
    _foodKMLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userImgV.frame), CGRectGetMaxY(_foodLocationLB.frame)+PinDanCellJianJu*2, kScreenWidth/1.5, 10)];
    //_foodKMLB.text = [NSString stringWithFormat:@"地点距离:  测试数据"] ;
    
    [self.view addSubview:_foodKMLB];
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetHeight(self.frame)-1, kScreenWidth-10, 1)];
    //    lineView.backgroundColor = [UIColor blackColor];
    //    [self.contentView addSubview:lineView];
    NSLog(@"%.f",CGRectGetMaxY(_foodKMLB.frame));
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
