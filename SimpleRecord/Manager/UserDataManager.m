//
//  UserDataManager.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "UserDataManager.h"
#import <FMDB/FMDB.h>
#import <sqlite3.h>

#define SimpleRecordDB                 @"SimpleRecordDB.sqlite"

#define CreateUserInfo               @"CREATE TABLE IF NOT EXISTS T_USERINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT NOT NULL, PASSWORLD TEXT NOT NULL);"
#define InsertToUserInfor            @"INSERT INTO T_SECRETINFO (USERNAME,PASSWORLD) VALUES (%@,%@);"
#define UpdateUserInfor              @"UPDATE T_SECRETINFO SET USERNAME = %@ , PASSWORLD = %@ WHERE id = %i ;"
#define DeleteUserInfor              @"DELETE FORM T_SECRETINFO WHERE id = %i ;"

#define CreateSecretInfo               @"CREATE TABLE IF NOT EXISTS T_SECRETINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, USERID TEXT NOT NULL);"
#define InsertToSecretInfor            @"INSERT INTO T_SECRETINFO (ADDTIME,CONTENT,USERID) VALUES (%@,%@,%@);"
#define UpdateSecretInfor              @"UPDATE T_SECRETINFO SET CONTENT = %@ WHERE ADDTIME = %@,USERID = %@;"
#define DeleteSecretInfor              @"DELETE FORM T_SECRETINFO WHERE ADDTIME = %@,USERID = %@;"

#define CreateArticleTable             @"CREATE TABLE IF NOT EXISTS T_ARTICLE (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, LASTUPDATETIME TEXT NOT NULL,USERID TEXT NOT NULL);"
#define InsertToArticleTable           @"INSERT INTO T_ARTICLE (ADDTIME,CONTENT,LASTUPDATETIME,USERID) VALUES (%@,%@,%@);"
#define UpdateArticleTable             @"UPDATE T_ARTICLE SET CONTENT = %@, LASTUPDATETIME = %@ WHERE id = %i,USERID = %@ ;"
#define DeleteArticleTable             @"DELETE FORM T_ARTICLE WHERE id = %i,USERID = %@ ;"

@interface UserDataManager()

@end

@implementation UserDataManager

+ (instancetype)sharedInstance {
    static UserDataManager *_sharedIntace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedIntace = [[UserDataManager alloc] init];
        
    });
    return _sharedIntace;
}

- (void)createDefaltDatabase {
    [self createDataBaseWithName:SimpleRecordDB];
    
}

- (void)loadUser {
    
}

- (FMDatabase *)createDataBaseWithName: (NSString *)DBNameStr{
    //APP所在路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                                                               NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    
    //往应用程序路径中添加数据库文件名称，把它们拼接起来
    NSString *dbFilePath = [documentFolderPath stringByAppendingPathComponent:DBNameStr];
    
    //没有则创建
    FMDatabase *dataBase=[FMDatabase databaseWithPath:dbFilePath];
    
    return dataBase;
}

@end
