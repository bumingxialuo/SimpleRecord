//
//  CalendarViewModel.m
//  SimpleRecord
//
//  Created by xia on 2018/4/25.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "CalendarViewModel.h"

@interface CalendarViewModel()
{
    CalendarDataModel *_model;
}
@end

@implementation CalendarViewModel

- (instancetype)initWithModel:(CalendarDataModel *)model {
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}
- (NSString *)addYear {
    NSArray *arr = [_model.addTime componentsSeparatedByString:@"-"];
    return arr[0] ? arr[0] : @"";
}

- (NSString *)addMonthAndDay {
    NSArray *arr = [_model.addTime componentsSeparatedByString:@"-"];
    NSString *returnStr = @"";
    if (arr[1] && arr[2]) {
        returnStr = [NSString stringWithFormat:@"%@月%@日",arr[1],arr[2]];
    }
    return returnStr;
}
- (NSString *)title {
    if (_model.content.length >= 6) {
        return [_model.content substringToIndex:6];
    } else {
        return _model.content;
    }
}

- (NSString *)content {
    return _model.content;
}
@end
