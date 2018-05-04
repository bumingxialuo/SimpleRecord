//
//  RecordDataModel.h
//  SimpleRecord
//
//  Created by xia on 2018/4/23.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface RecordDataModel : JSONModel

@property(nonatomic, copy) NSString *articleId;

@property(nonatomic, copy) NSString *addTime;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *updateTime;

@property(nonatomic, copy) NSString *modifyNum;

@property(nonatomic, copy) NSString *title;

@end
