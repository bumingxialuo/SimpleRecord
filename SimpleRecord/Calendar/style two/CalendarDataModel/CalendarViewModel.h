//
//  CalendarViewModel.h
//  SimpleRecord
//
//  Created by xia on 2018/4/25.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarDataModel.h"

@interface CalendarViewModel : NSObject
@property(nonatomic,copy) NSString *addYear;
@property(nonatomic,copy) NSString *addMonthAndDay;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;

- (instancetype)initWithModel:(CalendarDataModel *)model;
@end
