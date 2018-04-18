//
//  SRUserDiaryProfile.h
//  SimpleRecord
//
//  Created by xia on 2018/4/18.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRUserDiaryProfile : NSObject
@property(nonatomic, copy) NSString *addTime;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *userName;

+ (instancetype)sharedInstance;

- (BOOL)saveDiary;

- (BOOL)removeDiary;

- (void)findOneDiary ;

- (void)findAllDiary ;

@end
