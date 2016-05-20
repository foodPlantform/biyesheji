//
//  OldPindDanVC.m
//  foodplantform
//
//  Created by 斌斌斌 on 16/5/19.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "OldPindDanVC.h"
#import "BmobOrderModel.h"
#import "OldOrderCell.h"
@interface OldPindDanVC ()
@property (nonatomic ,strong)NSMutableArray * oldOrderDataArr;
@end

@implementation OldPindDanVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    _oldOrderDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self.tableView registerClass:[OldOrderCell class] forCellReuseIdentifier:@"OldOrderCell"];
    self.tableView.rowHeight = 65+10;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setUserID:(NSString *)userID
{
    _userID = userID;
    //查找user_order表
   BmobQuery * _userOldOrderQuery = [BmobQuery queryWithClassName:@"user_order"];
    //1已完成 0未完成
    [_userOldOrderQuery addTheConstraintByAndOperationWithArray:@[@{@"order_Type":@"1"},@{@"order_senderID":_userID}]];
    [_userOldOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [_oldOrderDataArr removeAllObjects];
        for (BmobObject*obj in array) {
            BmobOrderModel  *model = [[BmobOrderModel alloc] initWithBomdModel:obj];
            //查找评论表
            BmobQuery * _userPinlunOrderQuery = [BmobQuery queryWithClassName:@"pinlun"];
            //1已完成 0未完成
            [_userPinlunOrderQuery addTheConstraintByAndOperationWithArray:@[@{@"ordid":_userID}]];
            
            [_userPinlunOrderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                //计算综合评价数
               float AllPinjiaStar = 0;
               for (BmobObject*pinlunObj in array)
               {
                   float pinjiaStar = [[pinlunObj objectForKey:@"star"] floatValue];
                   AllPinjiaStar +=pinjiaStar;
               }
                model.allPinLunStar =array.count==0?5: AllPinjiaStar /(float) array.count;
                model.pinLunOrderArr = array;
                [_oldOrderDataArr addObject:model];
                 [self.tableView reloadData];
            }];
            
            
        }
       
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return _oldOrderDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    BmobOrderModel *model = _oldOrderDataArr[section];
    return model.pinLunOrderArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OldOrderCell" ;
    
    OldOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[OldOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    BmobOrderModel *model = _oldOrderDataArr[indexPath.section];
    BmobObject *objc = model.pinLunOrderArr[indexPath.row];
    cell.pinlunUserNameLB.text = [NSString stringWithFormat:@"%@:%@" , [objc objectForKey:@"username"], [objc objectForKey:@"content"]]  ;
    cell.pinLunStarView.value =  [[objc objectForKey:@"star"] floatValue];
    
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:@"第%ld组第%ld列",indexPath.section,indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 60+10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    BmobOrderModel *model = _oldOrderDataArr[section];
    UIView *oldOrderView= [[UIView alloc] init];
    UILabel *oldOrderNameLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth/2.0, 10)];
    oldOrderNameLB.text =  [NSString stringWithFormat:@"拼单名称：%@",model.name];
    [oldOrderView addSubview:oldOrderNameLB];
    UILabel *oldOrderPingjiaLB = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(oldOrderNameLB.frame)+20, kScreenWidth/4.0, 10)];
    oldOrderPingjiaLB.text =  [NSString stringWithFormat:@"综合评价："];
    [oldOrderView addSubview:oldOrderPingjiaLB];
   HCSStarRatingView * _pinLunStarView = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oldOrderPingjiaLB.frame), CGRectGetMinY(oldOrderPingjiaLB.frame), 100, 20)];
    _pinLunStarView.maximumValue = 5;
    _pinLunStarView.minimumValue = 0;
    _pinLunStarView.allowsHalfStars = YES;
    _pinLunStarView.value = model.allPinLunStar;
    _pinLunStarView.tintColor = [UIColor redColor];
    _pinLunStarView.enabled = NO;
    [oldOrderView addSubview:_pinLunStarView];
     //NSLog(@"---------------%f", CGRectGetMaxY(_pinLunStarView.frame));

    return oldOrderView;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
