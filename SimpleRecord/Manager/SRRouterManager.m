//
//  SRRouterManager.m
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "SRRouterManager.h"

@implementation SRRouterManager

+ (SRRouterManager *)shardInstance {
    static SRRouterManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)createAllRouterController {
    [[HHRouter shared] map:SR_Calendar toControllerClass:NSClassFromString(@"CalendarViewController")];
    [[HHRouter shared] map:SR_Record toControllerClass:NSClassFromString(@"RecordViewController")];
    [[HHRouter shared] map:SR_Mine toControllerClass:NSClassFromString(@"MineViewController")];
}
@end
