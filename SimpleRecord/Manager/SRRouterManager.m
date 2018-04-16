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
    [self createCalendarRouter];
    [self createRecordRouter];
    [self createMineRouter];
}

- (void)createCalendarRouter {
    [[HHRouter shared] map:SR_Calendar toControllerClass:NSClassFromString(@"CalendarViewController")];
    [[HHRouter shared] map:SR_CalendarStyleTwo toControllerClass:NSClassFromString(@"CalendarStyleTwoViewController")];
    [[HHRouter shared] map:SR_Calendar_AddDiary(@":navTitle",@":style") toControllerClass:NSClassFromString(@"AddDiaryViewController")];
}

- (void)createRecordRouter {
    [[HHRouter shared] map:SR_Record toControllerClass:NSClassFromString(@"RecordViewController")];
    [[HHRouter shared] map:SR_RecordStyleTwo toControllerClass:NSClassFromString(@"RecordStyleTwoViewController")];
}

- (void)createMineRouter {
    [[HHRouter shared] map:SR_Mine toControllerClass:NSClassFromString(@"MineViewController")];
    [[HHRouter shared] map:SR_Mine_DiaryList toControllerClass:NSClassFromString(@"DiaryListViewController")];
    [[HHRouter shared] map:SR_Mine_ArticleList toControllerClass:NSClassFromString(@"ArticleListViewController")];
    [[HHRouter shared] map:SR_Mine_FunctionConfig toControllerClass:NSClassFromString(@"FunctionConfigurationViewController")];
    [[HHRouter shared] map:SR_Mine_ChangeStyle toControllerClass:NSClassFromString(@"ChageAppStyleViewController")];
    [[HHRouter shared] map:SR_Mine_AccountManager toControllerClass:NSClassFromString(@"AccountManagerViewController")];
    [[HHRouter shared] map:SR_Mine_ChangeStyle_ColorSlider(@":title") toControllerClass:NSClassFromString(@"ChangeAppStyleDetailViewController")];
}
@end
