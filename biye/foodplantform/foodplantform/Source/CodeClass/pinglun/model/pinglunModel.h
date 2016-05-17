//
//  pinglunModel.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/16.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pinglunModel : NSObject
@property(nonatomic,strong) NSString * ordID;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * content;
@property(nonatomic,strong) NSString *star;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
