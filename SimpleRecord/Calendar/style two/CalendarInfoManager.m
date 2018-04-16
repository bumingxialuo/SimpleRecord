//
//  CalendarInfoManager.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/14.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "CalendarInfoManager.h"

@interface CalendarInfoManager()
@property (nonatomic, strong) NSMutableArray *dateList;
@end

@implementation CalendarInfoManager
static CalendarInfoManager *sharedManager = nil;
+ (CalendarInfoManager *)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        sharedManager = [[self alloc] init];
        sharedManager.dateList = [[NSMutableArray alloc] init];
    });
    return sharedManager;
}

- (BOOL)insert:(CalendarDataModel *)calendar {
    if ([self.dateList count] > 0) {
        CalendarDataModel *lastNote = [self.dateList lastObject];
        NSInteger noteId = [lastNote.noteId integerValue];
        noteId ++;
        calendar.noteId = [NSString stringWithFormat:@"%ld",(long)noteId];
        [self.dateList addObject:calendar];
    } else {
        calendar.noteId = @"1";
        [self.dateList addObject:calendar];
    }
    return YES;
}

- (BOOL)insertOrUpdate:(CalendarDataModel *)calendar {
    if ([self findByDateStr:calendar.date]) {
        [self modify:calendar];
    } else {
        [self insert:calendar];
    }
    return YES;
}
- (BOOL)modify:(CalendarDataModel *)calendar {
    for (CalendarDataModel *n in self.dateList) {
        if ([n.date isEqualToString:calendar.date]) {
            n.content = calendar.content;
            return YES;
        }
    }
    return NO;
}

- (BOOL)remove:(CalendarDataModel *)calendar {
    for (NSInteger i = 0; i < [self.dateList count]; i++) {
        CalendarDataModel *n = [self.dateList objectAtIndex:i];
        if ([n.noteId isEqualToString:calendar.noteId]) {
            [self.dateList removeObjectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

- (CalendarDataModel *)findById:(CalendarDataModel *)calendar {
    for (CalendarDataModel *n in self.dateList) {
        if ([n.noteId isEqualToString:calendar.noteId]) {
            return n;
        }
    }
    return nil;
}
- (CalendarDataModel *)findByDateStr:(NSString *)dateString {
    for (CalendarDataModel *n in self.dateList) {
        if ([n.date isEqualToString:dateString]) {
            return n;
        }
    }
    return nil;
}

- (CalendarDataModel *)findByDate:(NSDate *)oneDate{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [format stringFromDate:oneDate];
    return [self findByDateStr:dateStr];
}

- (NSMutableArray *)findAllDatas {
    return self.dateList;
}
@end
