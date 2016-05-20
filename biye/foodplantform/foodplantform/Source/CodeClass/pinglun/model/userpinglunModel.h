//
//  userpinglunModel.h
//  foodplantform
//
//  Created by 马文豪 on 16/5/20.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userpinglunModel : NSObject
@property(nonatomic,strong) NSString * rec_userid;
@property(nonatomic,strong) NSString * userid;
@property(nonatomic,strong) NSString * content;
@property(nonatomic,strong) NSString *star;
@property(nonatomic,strong) NSString *name;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
