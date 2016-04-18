//
//  MessageViewController.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableView.h"
#import "MessageTableViewCell.h"
@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)MessageTableView * messageTV;

@end

@implementation MessageViewController

-(void)loadView{
    //用自己定制的Tableview代替该controller本身的视图
    _messageTV = [[MessageTableView alloc]initWithFrame:[[UIScreen mainScreen ]bounds]];
    self.view = _messageTV;
}

- (void)viewDidLoad {
    
    //设置代理
    _messageTV.tableView.delegate = self;
    _messageTV.tableView.dataSource = self;
    //注册Cell
    [_messageTV.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    [super viewDidLoad];
    
}


//tableView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.headImage.image = [UIImage imageNamed:@"头像"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
