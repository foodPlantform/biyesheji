//
//  pinglunViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/8.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "pinglunViewController.h"
#import "pinglunTableViewCell.h"
@interface pinglunViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation pinglunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-170);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[pinglunTableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.重用标示符
    static NSString *cell_id = @"cell";
     //2.去重用池寻找有此标示符的cell
    pinglunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
     //3.做判断
    if (cell == nil) {
        cell = [[pinglunTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }

   
    
    //cell.userName.text = @"qwer";
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
