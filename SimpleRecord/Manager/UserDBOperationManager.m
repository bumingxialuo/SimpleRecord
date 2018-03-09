//
//  UserDBOperationManager.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "UserDBOperationManager.h"
#import "UserDataManager.h"

@implementation UserDBOperationManager

+ (instancetype)sharedInstance {
    static UserDBOperationManager *shardInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shardInstance = [[UserDBOperationManager alloc] init];
    });
    return shardInstance;
}

@end
