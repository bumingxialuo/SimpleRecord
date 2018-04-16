//
//  CalendarDataModel.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/14.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDataModel : NSObject

@property (nonatomic, copy) NSString *noteId;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, copy) NSString *content;

@end
