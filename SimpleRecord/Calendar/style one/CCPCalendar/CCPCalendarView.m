//
//  CCPCalendarView.m
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarView.h"
#import "CCPCalendarHeader.h"
#import "NSDate+CCPCalendar.h"
#import "UIView+CCPView.h"
#import "CCPCalendarModel.h"
#import "CCPCalendarTable.h"
#import "Macro.h"

@interface CCPCalendarView()
{
    CGFloat bottomH;
    //底部按钮
    UIButton *saveBtn;
    CGFloat scrStart;

}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) CCPCalendarHeader *headerView;
@property (nonatomic, strong) CCPCalendarTable *tableView;
@end

@implementation CCPCalendarView

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)initSubviews {
    [self headerView];
    [self tableView];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _dateFormatter.timeZone = [NSTimeZone localTimeZone];
        _dateFormatter.locale = [NSLocale currentLocale];
    }
    return _dateFormatter;
}

- (CCPCalendarHeader *)headerView {
    if (!_headerView) {
        _headerView = [[CCPCalendarHeader alloc] init];
        [_headerView initSubviews];
        CGFloat h = [_headerView getSupH];
        _headerView.frame = CGRectMake(0, 0, WIDTHOFSCREEN, 50);
        [self addSubview:_headerView];
    }
    return _headerView;
}

- (CCPCalendarTable *)tableView {
    if (!_tableView) {
        _tableView = [[CCPCalendarTable alloc] initWithFrame:CGRectMake(0, 50, WIDTHOFSCREEN, HEIGHTOFSCREEN-50) style:UITableViewStylePlain];
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
