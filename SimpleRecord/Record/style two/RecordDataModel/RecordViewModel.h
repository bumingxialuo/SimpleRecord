//
//  RecordViewModel.h
//  SimpleRecord
//
//  Created by xia on 2018/4/28.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordDataModel.h"

@interface RecordViewModel : NSObject

@property(nonatomic, copy) NSString *articleId;

@property(nonatomic, copy) NSString *addYear;

@property(nonatomic, copy) NSString *createMonth;

@property(nonatomic, copy) NSString *title;

- (instancetype)initWithModel:(RecordDataModel *)model;
@end
