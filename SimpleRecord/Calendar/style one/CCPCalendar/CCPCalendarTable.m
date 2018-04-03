//
//  CCPCalendarTable.m
//  CCPCalendar
//
//  Created by 储诚鹏 on 17/5/28.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarTable.h"
#import "NSDate+CCPCalendar.h"
#import "CCPCalendarCellTableViewCell.h"
#import "UIView+CCPView.h"


@implementation CCPCalendarTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        _exitViews = [NSMutableArray array];
        [self.dates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_exitViews addObject:@""];
        }];
        [self registerClass:[CCPCalendarCellTableViewCell class] forCellReuseIdentifier:@"cell"];
        NSInteger a = self.dates.count / 2;
        __block CGFloat y = 0;
        [self.dates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < a) {
                y += [self getHWithDate:obj];
            }
        }];
        [self setContentOffset:CGPointMake(0, y)];
        self.bounces = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSArray<NSDate *> *)dates {
    if (!_dates) {
        NSDate *date = [NSDate date];
        NSMutableArray *mDates = [NSMutableArray array];
        for (int i = 0; i < 13; i ++) {
            [mDates addObject:[date addMonth:i]];
        }
       
        _dates = mDates.copy;
    }
    return _dates;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dates.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCPCalendarCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDate *date = self.dates[indexPath.row];
    if (!cell) {
        cell = [CCPCalendarCellTableViewCell new];
    }
    else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if ([self.exitViews[indexPath.row] isKindOfClass:[UIView class]]) {
            [cell.contentView addSubview:self.exitViews[indexPath.row]];
        }
        else {
            UIView *av = [cell createDateView:date];
            [self.exitViews replaceObjectAtIndex:indexPath.row withObject:av];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *date = self.dates[indexPath.row];
    return [self getHWithDate:date];
}

- (CGFloat)getHWithDate:(NSDate *)date {
    NSInteger week = [date firstDay_week];
    NSInteger days = [date dayOfMonth];
    NSInteger week_last = [date lastDay_week];
    NSInteger count = week + days + 6 - week_last;
    NSInteger h = count / 7;
    if (count % 7 > 0) {
        h += 1;
    }
    return h * main_width / 7 + 49 * scale_h;
}


@end
