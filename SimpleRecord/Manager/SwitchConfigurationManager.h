//
//  SwitchConfigurationManager.h
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 日历页方案
 */
typedef NS_ENUM(NSInteger, CalendarStyle)
{
    /*
     方案一
     */
    CalendarStyleOne = 1,
};

typedef NS_ENUM(NSInteger, RecordStyle)
{
    /*
     列表方案
     */
    RecordTypeSimpleTable = 1,
    /*
     动画
     */
    RecordTypeAnimationTable = 2,
};

@interface SwitchConfigurationManager : NSObject

+ (instancetype)sharedInstance;

-(void)initFeatures;

@property(nonatomic, assign) CalendarStyle calendarStyleValue;

@property(nonatomic, assign) RecordStyle RecordStyleValue;

@property(nonatomic, assign) BOOL SwichConfigurationRecord;

@end
