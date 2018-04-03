//
//  CCPCalendarHeader.m
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarHeader.h"
#import "UIView+CCPView.h"
#import "NSDate+CCPCalendar.h"

@interface CCPCalendarHeader()
{
    /*
     * l_gap,r_gap 左右距离
     * big_l_gap,big_r_gap 大字左右距离
     * t_gap 上方间距
     */
    CGFloat l_gap,r_gap,big_l_gap,big_r_gap,t_gap;
    
}
@end

@implementation CCPCalendarHeader

- (instancetype)init {
    if (self = [super init]) {
        l_gap = r_gap = scale_w * 20.0;
        big_l_gap = big_r_gap = scale_w * 25.0;
        t_gap = scale_h * 15;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initSubviews {
    [self weeks];
    CGFloat h = [self getSupH];
    UIView *bLine = [[UIView alloc] initWithFrame:CGRectMake(0, h, main_width, 1)];
    bLine.backgroundColor = rgba(255, 255, 255, 0.2);
    [self addSubview:bLine];
}

//星期
- (void)weeks {
    NSArray *arr = @[@"SUN", @"Mon", @"TUE", @"WED", @"THU", @"FRI", @"SAT"];
    CGFloat w = main_width / 7;
    CGFloat y;
    for (int idx = 0; idx < arr.count; idx ++) {
        NSString *week = arr[idx];
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(w * idx , 15 * scale_h, w, 25 * scale_h)];
        y = CGRectGetMaxY(weekLabel.frame);
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.font = [UIFont systemFontOfSize:14 * scale_h];
        weekLabel.textColor = [UIColor whiteColor];
        weekLabel.text = week;
        [self addSubview:weekLabel];
    }
}

@end
