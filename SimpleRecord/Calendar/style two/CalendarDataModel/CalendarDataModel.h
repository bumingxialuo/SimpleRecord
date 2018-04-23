//
//  CalendarDataModel.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/14.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface CalendarDataModel : JSONModel

@property (nonatomic, strong) NSString *addTime;

@property (nonatomic, copy) NSString *content;

@end
