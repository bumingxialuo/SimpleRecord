//
//  UserDBOperationManager.h
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRAppUserProfile.h"
#import "SRUserDiaryProfile.h"
#import "SRUserArticleProfile.h"
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

//-------------- User Info -------------------

- (BOOL)savetUserInfo:(SRAppUserProfile *)userInfo;

- (void)updateUserInfo:(SRAppUserProfile *)userInfo;

- (BOOL)userLogOut:(SRAppUserProfile *)userInfo;

- (void)loadUser:(SRAppUserProfile *)userInfo;

//-------------- Diary -------------------

- (BOOL)saveDiaryInfo:(SRUserDiaryProfile *)oneDiary;

- (BOOL)removeDiary:(SRUserDiaryProfile *)oneDiary;

- (void)loadOneDiary:(SRUserDiaryProfile *)oneDiary;

- (void)loadAllDiary:(NSArray<SRUserDiaryProfile *> *) allDiary;

//-------------- Articel -------------------

- (BOOL)saveArticleInfo:(SRUserArticleProfile *)oneArticle;

- (BOOL)removeArticle:(SRUserArticleProfile *)oneArticle;

- (void)loadOneArticle:(SRUserArticleProfile *)oneArticle;

- (void)loadAllArticle:(NSArray<SRUserArticleProfile *> *) allArticle;



@end