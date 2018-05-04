//
//  CCPCalendarCellTableViewCell.m
//  CCPCalendar
//
//  Created by 储诚鹏 on 17/5/28.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarCellTableViewCell.h"
#import "CCPCalendarButton.h"
#import "UIView+CCPView.h"
#import "UILabel+CCPLabel.h"

@implementation CCPCalendarCellTableViewCell
/*
 * 生成一个月的日历
 */
- (UIView *)createDateView:(NSDate *)date {
    UIView *dateSupV = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat t_gap = 15 * scale_h;
    CGFloat l_gap = 25 * scale_w;
    CGFloat label_h = 24 * scale_h;
    UILabel *bigLabel = [[UILabel alloc] init];
    [bigLabel setFont:[UIFont boldSystemFontOfSize:bigLabel.font.pointSize]];
    NSString *label_text;
    
    NSString *month = [NSString stringWithFormat:@"%02ld",(long)[date getMonth]];
    
    if ([date getYear]) {
        month = [NSString stringWithFormat:@"%@月",month];
        label_text = month;
    }
    else {
        label_text = [NSString stringWithFormat:@"%ld年%@",(long)[date getYear],month];
    }
    bigLabel.text = label_text;
    bigLabel.backgroundColor = [UIColor clearColor];
    CGFloat label_w = [bigLabel widthBy:label_h];
    bigLabel.frame = CGRectMake(l_gap, t_gap, label_w, label_h);
    bigLabel.textColor = [UIColor whiteColor];
    [dateSupV addSubview:bigLabel];
    NSInteger week = [date firstDay_week];
    NSInteger week_last = [date lastDay_week];
    NSInteger days = [date dayOfMonth];
    CGFloat w = main_width / 7;
    NSInteger count = week + days + 6 - week_last;
    for (int i = 0; i < count; i++) {
        NSInteger row = i / 7;
        NSInteger column = i - row * 7;
        CCPCalendarButton *btn = [[CCPCalendarButton alloc] initWithFrame:CGRectMake(column * w, row * w + CGRectGetMaxY(bigLabel.frame) + 10 * scale_h, w, w)];
        NSString *ym = [NSString stringWithFormat:@"%ld%02ld%02d",[date getYear],[date getMonth],i];
        btn.tag = [ym integerValue];
        btn.date = [date changToDay:i - week + 1];
        btn.enabled = NO;
        if (i >= week && i < (count + week_last - 6)) {
            NSString * titleNum = [NSString stringWithFormat:@"%ld",i - week + 1];
            btn.enabled = YES;
            [btn ccpDispaly];
            [btn setTitle:titleNum forState:UIControlStateNormal];
        }
        [dateSupV addSubview:btn];

    }
    dateSupV.backgroundColor = [UIColor clearColor];
    CGFloat h = [dateSupV getSupH];
    dateSupV.frame = CGRectMake(0, 0, main_width, h);
    [self.contentView addSubview:dateSupV];
    return dateSupV;
}
@end
