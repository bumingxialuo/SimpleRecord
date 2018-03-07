//
//  UserDBOperationManager.h
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDBOperationManager : NSObject

+ (instancetype)sharedInstance;
/**
 *日记
 */
@property(nonatomic,copy) NSString *diary;
/**
 *文章
 */
@property(nonatomic,copy) NSString *article;
/**
 *添加日期
 */
@property(nonatomic,copy) NSString *addTime;
/**
 *最后修改日期
 */
@property(nonatomic,copy) NSString *lastUpdateTime;
/**
 *手势密码
 */
@property(nonatomic,copy) NSString *gesturesPassword;

@end
