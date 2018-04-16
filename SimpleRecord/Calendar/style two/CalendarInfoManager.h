//
//  CalendarInfoManager.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/14.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarDataModel.h"

@interface CalendarInfoManager : NSObject

+ (CalendarInfoManager *)sharedManager;

- (BOOL)insertOrUpdate:(CalendarDataModel *)calendar;

- (BOOL)remove:(CalendarDataModel *)calendar;

- (NSMutableArray *)findAllDatas;

- (CalendarDataModel *)findById:(CalendarDataModel *)calendar;

- (CalendarDataModel *)findByDateStr:(NSString *)dateString;

- (CalendarDataModel *)findByDate:(NSDate *)oneDate;

@end
