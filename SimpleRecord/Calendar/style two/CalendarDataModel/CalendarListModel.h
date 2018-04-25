//
//  CalendarListModel.h
//  SimpleRecord
//
//  Created by xia on 2018/4/25.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarDataModel.h"
#import <JSONModel/JSONModel.h>

@protocol CalendarDataModel<NSObject>
@end

@interface CalendarListModel : JSONModel
@property(nonatomic,strong) NSArray<CalendarDataModel> *list;
@end
