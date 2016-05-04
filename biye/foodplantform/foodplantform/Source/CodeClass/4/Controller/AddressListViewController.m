//
//  AddressListViewController.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/4/18.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "AddressListViewController.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
#define IS_IPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define IS_IPhone6plus (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define IS_IPhone4s (480 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define TabBarHeight 49.0f
#define navBarHeight 64.0f
@interface AddressListViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_search;
    UITableView *_tb;
    //头部视图高度
    CGFloat headViewHeight;
    //图标大小
    CGFloat iconSize;
    //cell高
    CGFloat cellHeight;
    //label高度
    CGFloat labelHeight;
    //字体大小
    CGFloat titleSize;
    //间隔距离
    CGFloat interval;
}

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"通信录";
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航背景"] forBarMetrics:UIBarMetricsDefault];
//     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self adaptation];

     
}

#pragma 适配
-(void)adaptation
{
    if (IS_IPhone6)
    {
        headViewHeight = 165.0;
        cellHeight = 55.0;
        iconSize = 28.0;
        labelHeight = 26.0;
        titleSize = 16.0;
        interval = 155.0;
    }
    else if (IS_IPhone6plus)
    {
        headViewHeight = 185.0;
        cellHeight = 65.0;
        iconSize = 34.0;
        labelHeight = 32.0;
        titleSize = 16.0;
        interval = 185.0;
    }
    else if (IS_IPHONE5)
    {
        headViewHeight = 140.0;
        cellHeight = 45.0;
        iconSize = 20.0;
        labelHeight = 20.0;
        titleSize = 14.0;
        interval = 120.0;
    }
    else if (IS_IPhone4s)
    {
        headViewHeight = 110.0;
        cellHeight = 35.0;
        iconSize = 20.0;
        labelHeight = 20.0;
        titleSize = 14.0;
        interval = 120.0;
    }
    [self createUI];
}
-(void)createUI
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 169)];
    headView.backgroundColor = [UIColor whiteColor];
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    message.frame = CGRectMake(0, 0, Screen_Width, cellHeight);
    message.backgroundColor = [UIColor whiteColor];
    [headView addSubview:message];
    UIImageView *messageIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, message.frame.size.height/2-iconSize/2, iconSize, iconSize)];
    messageIcon.image = [UIImage imageNamed:@"邮箱"];
    [message addSubview:messageIcon];
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(messageIcon.frame)+20, message.frame.size.height/2 - labelHeight/2, 100, labelHeight)];
    messageLabel.text = @"聊天消息";
    messageLabel.font = [UIFont systemFontOfSize:titleSize];
    messageLabel.textColor = [UIColor colorWithRed:83.0/255.0 green:83.0/255.0 blue:83.0/255.0 alpha:1.0];
    [message addSubview:messageLabel];
    UIButton *newFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    newFriend.frame = CGRectMake(0, CGRectGetMaxY(message.frame)+2, Screen_Width, cellHeight);
    newFriend.backgroundColor = [UIColor whiteColor];
    [headView addSubview:newFriend];
    UIImageView *newFriendIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, newFriend.frame.size.height/2-iconSize/2, iconSize, iconSize)];
    newFriendIcon.image = [UIImage imageNamed:@"新朋友"];
    [newFriend addSubview:newFriendIcon];
    UILabel *newFriendLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newFriendIcon.frame)+20, newFriend.frame.size.height/2 - labelHeight/2, 100, labelHeight)];
    newFriendLabel.text = @"新朋友";
    newFriendLabel.font = [UIFont systemFontOfSize:titleSize];
    newFriendLabel.textColor = [UIColor colorWithRed:83.0/255.0 green:83.0/255.0 blue:83.0/255.0 alpha:1.0];
    [newFriend addSubview:newFriendLabel];
    UIButton *nearby = [UIButton buttonWithType:UIButtonTypeCustom];
    nearby.frame = CGRectMake(0, CGRectGetMaxY(newFriend.frame)+2, Screen_Width, cellHeight);
    nearby.backgroundColor = [UIColor whiteColor];
    [headView addSubview:nearby];
    UIImageView *nearbyIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, nearby.frame.size.height/2-iconSize/2, iconSize, iconSize)];
    nearbyIcon.image = [UIImage imageNamed:@"附近的人"];
    [nearby addSubview:nearbyIcon];
    UILabel *nearbyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nearbyIcon.frame)+20, nearby.frame.size.height/2 - labelHeight/2, 100, labelHeight)];
    nearbyLabel.text = @"附近的人";
    nearbyLabel.font = [UIFont systemFontOfSize:titleSize];
    nearbyLabel.textColor = [UIColor colorWithRed:83.0/255.0 green:83.0/255.0 blue:83.0/255.0 alpha:1.0];
    [nearby addSubview:nearbyLabel];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(message.frame), Screen_Width-15, 1)];
    line1.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:223.0/255.0 alpha:1.0];
    [headView addSubview:line1];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(newFriend.frame), Screen_Width-15, 1)];
    line2.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:223.0/255.0 alpha:1.0];
    [headView addSubview:line2];
    [message addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    [newFriend addTarget:self action:@selector(newFriendClick:) forControlEvents:UIControlEventTouchUpInside];
    [nearby addTarget:self action:@selector(nearbyClick:) forControlEvents:UIControlEventTouchUpInside];
    _tb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - navBarHeight) style:UITableViewStyleGrouped];
    _tb.showsHorizontalScrollIndicator = NO;
    _tb.showsVerticalScrollIndicator = NO;
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableHeaderView = headView;
    [self.view addSubview:_tb];
}

#pragma mark -按钮的点击事件
-(void)messageClick:(UIButton *)button
{
    
//    [self uiAlertViewWithTitle:@"提示:" message:@"即将开放,敬请期待" cancelButtonTitle:@"确定" otherButtonTitle:nil tag:NULL];
    
}
-(void)newFriendClick:(UIButton *)button
{
//    [self uiAlertViewWithTitle:@"提示:" message:@"即将开放,敬请期待" cancelButtonTitle:@"确定" otherButtonTitle:nil tag:NULL];
}
-(void)nearbyClick:(UIButton *)button
{
//    [self uiAlertViewWithTitle:@"提示:" message:@"即将开放,敬请期待" cancelButtonTitle:@"确定" otherButtonTitle:nil tag:NULL];
}
#pragma mark-代理方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_search resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_search resignFirstResponder];
    return YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return cellHeight;
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
