//
//  SRUserDiaryProfile.m
//  SimpleRecord
//
//  Created by xia on 2018/4/18.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "SRUserDiaryProfile.h"
#import "UserDBOperationManager.h"
#import "SRAppUserProfile.h"

@implementation SRUserDiaryProfile

static  SRUserDiaryProfile *sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SRUserDiaryProfile alloc] init];
    });
    return sharedInstance;
}

- (BOOL)saveDiary {
    return [[UserDBOperationManager sharedInstance] saveDiaryInfo:self];
}

- (BOOL)removeDiary {
    BOOL reslut = [[UserDBOperationManager sharedInstance] removeDiary:self];
    _userName = @"";
    _content = @"";
    _addTime = @"";
    return reslut;
}

- (void)findOneDiary {
    [[UserDBOperationManager sharedInstance] loadOneDiary:self];
}

- (NSString *)findOneDiaryStr {
    NSString *contentStr = [[UserDBOperationManager sharedInstance] loadOneDiaryReturnStr:self];
    return contentStr;
}

//所有的新建一个文件
- (void)findAllDiary {
    
}

@end
