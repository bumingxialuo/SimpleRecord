//
//  RecordViewModel.m
//  SimpleRecord
//
//  Created by xia on 2018/4/28.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordViewModel.h"

@interface  RecordViewModel()
{
    RecordDataModel *_dataModel;
}
@end

@implementation RecordViewModel

- (instancetype)initWithModel:(RecordDataModel *)model {
    self = [super init];
    if (self) {
        _dataModel = model;
    }
    return self;
}

- (NSString *)articleId {
    return _dataModel.articleId;
}

- (NSString *)title {
    return _dataModel.title;
}

- (NSString *)addYear {
    NSArray *yearArray = [_dataModel.addTime componentsSeparatedByString:@"-"];
    return yearArray[0];
}

- (NSString *)createMonth {
    NSArray *yearArray = [_dataModel.addTime componentsSeparatedByString:@"-"];
    if (yearArray[1] && yearArray[2]) {
        return [NSString stringWithFormat:@"%@月%@日",yearArray[1],yearArray[2]];
    } else {
        return @"";
    }
}

@end
