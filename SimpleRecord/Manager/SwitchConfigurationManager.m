//
//  SwitchConfigurationManager.m
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "SwitchConfigurationManager.h"

@implementation SwitchConfigurationManager

static  SwitchConfigurationManager *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SwitchConfigurationManager alloc] init];
    });
    return sharedInstance;
}

- (void)initFeatures {
    _calendarStyleValue = 2;
    _RecordStyleValue = 2;
    _SwichConfigurationRecord = 1;
}

@end
