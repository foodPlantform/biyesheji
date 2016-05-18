//
//  doneOrderTableViewController.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/3.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface doneOrderTableViewController : UITableViewController
@property (nonatomic,strong)NSString *orderType;
@property (nonatomic,strong)NSString *orderOrFoodType;

@property(nonatomic,strong)MBProgressHUD *allOrderHud;

@end
