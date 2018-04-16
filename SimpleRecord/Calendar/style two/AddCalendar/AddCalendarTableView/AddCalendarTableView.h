//
//  AddCalendarTableView.h
//  SimpleRecord
//
//  Created by xia on 2018/4/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDataModel.h"

@protocol AddCalendarTableViewDelegate<NSObject>
- (void)getCalendarContextWithContext:(NSString *)str;
@end

@interface AddCalendarTableView : UITableView
@property(nonatomic, weak) id<AddCalendarTableViewDelegate> tableViewDelegate;
- (void)updateWithDataModel:(CalendarDataModel *)model;
@end
