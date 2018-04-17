//
//  UserDBOperationManager.h
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRAppUserProfile.h"
#import <FMDB/FMDB.h>

@interface UserDBOperationManager : NSObject


/**
 *  单例
 *
 *  @return 对象
 */
+ (instancetype) sharedInstance;
/**
 *  创建默认数据库
 */
- (void)createDefaultDataBase;
/**
 *  创建数据库
 *
 *  @param dataBaseName 数据库名字
 *
 *  @return 返回数据库对象
 */
- (FMDatabase *)createDataBaseName:(NSString *)dataBaseName;

//-------------------------------------------------------

- (BOOL)savetUserInfo:(SRAppUserProfile *)userInfo;

//- (void)updateUserInfo:(SRAppUserProfile *)userInfo gesturePWD:(NSString *)gesturePwd;
//
//- (void)updateUserInfo:(SRAppUserProfile *)userInfo openTouchID:(BOOL)open;

- (void)updateUserInfo:(SRAppUserProfile *)userInfo;

//- (BOOL)checkUserInfo:(SRAppUserProfile *)userInfo gesturePWD:(NSString *)gesturePwd;

//- (BOOL)userIsOpenTouchID:(SRAppUserProfile *)userInfo;

//- (void)loadUser:(SRAppUserProfile *)userInfo;

- (BOOL)userLogOut:(SRAppUserProfile *)userInfo;

//- (NSString *)getGesturePWD:(SRAppUserProfile *)userInfo;

@end
