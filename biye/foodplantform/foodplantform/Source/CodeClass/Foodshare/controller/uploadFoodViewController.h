//
//  uploadFoodViewController.h
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uploadFoodViewController : UIViewController
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)BmobObject *uploadObject;
-(void)uploadWith:(foodModel *)stuff username:(NSString *)userName image:(UIImage *)img;
@end
