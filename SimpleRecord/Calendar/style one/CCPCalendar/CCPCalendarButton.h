//
//  CCPCalendarButton.h
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+CCPCalendar.h"

#define main_width  [UIScreen mainScreen].bounds.size.width
#define main_height [UIScreen mainScreen].bounds.size.height
#define main_bounds [UIScreen mainScreen].bounds
#define rgba(r,g,b,a)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

//相对iphone6布局
#define scale_w main_width / 375.0
#define scale_h main_height / 667.0

@interface CCPCalendarButton : UIButton

//生成当前btn的date
@property (nonatomic, strong) NSDate *date;

- (void)ccpDispaly;
- (void)addObesers;
@end
