//
//  RecordListModel.h
//  SimpleRecord
//
//  Created by xia on 2018/4/24.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordDataModel.h"
#import <JSONModel/JSONModel.h>

@protocol RecordDataModel<NSObject>
@end

@interface RecordListModel : JSONModel
@property(nonatomic, strong) NSArray<RecordDataModel> *list;
@end
