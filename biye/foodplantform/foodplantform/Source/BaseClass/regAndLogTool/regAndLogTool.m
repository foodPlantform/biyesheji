//
//  regAndLogTool.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/27.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "regAndLogTool.h"

static regAndLogTool *rlt;
@implementation regAndLogTool
+(regAndLogTool *)shareTools
{
    static dispatch_once_t once_token;
    if (rlt == nil) {
        dispatch_once(&once_token, ^{
            rlt = [[regAndLogTool alloc]init];
        });
    }
    return rlt;
}


@end
