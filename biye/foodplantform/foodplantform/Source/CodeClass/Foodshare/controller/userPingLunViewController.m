//
//  userPingLunViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/19.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "userPingLunViewController.h"
#import "pinglunTableViewCell.h"
#import "userpinglunModel.h"


@interface userPingLunViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong) NSMutableArray *heightArr;
@property(nonatomic,assign) CGFloat max;
@end

@implementation userPingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightArr = [NSMutableArray array];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-170);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[pinglunTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.dataArr = [NSMutableArray array];
    BmobQuery *userQuery = [BmobQuery queryForUser];
    [userQuery whereKey:@"mobilePhoneNumber" equalTo:self.foodmodel_userpinglun.phone];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        
        BmobObject *userObj = array[0];
        
        BmobQuery *query = [BmobQuery queryWithClassName:@"userpinglun"];
        [query whereKey:@"rec_userid" equalTo:[userObj objectForKey:@"objectId"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                userpinglunModel *um = [[userpinglunModel alloc]init];
                um.rec_userid = [obj objectForKey:@"rec_userid"];
                um.content = [obj objectForKey:@"content"];
                um.name = [obj objectForKey:@"username"];
                um.star = [obj objectForKey:@"star"];
                [self.dataArr addObject:um];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        

        
    }];
   
    
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(CGFloat)heightforstring:(NSString *)str
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenWidth-20, 5000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
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
    userpinglunModel *um = self.dataArr[indexPath.row];
    cell.userName.text = um.name;
    cell.star.value = [um.star floatValue];
    
    cell.content.text = um.content;
    CGRect rect1 = cell.content.frame;
    rect1.size.height = [self heightforstring:um.content];
    self.height = rect1.size.height;
    [self.heightArr addObject:[NSNumber numberWithFloat:_height]];
    
    
    //cell.userName.text = @"qwer";
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 80;
    for (int i = 0; i<_heightArr.count; i++) {
        _max = 0;
        if ([_heightArr[i] floatValue] > _max) {
            _max = [_heightArr[i] floatValue];
        }
    }
    return _max+80;
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
