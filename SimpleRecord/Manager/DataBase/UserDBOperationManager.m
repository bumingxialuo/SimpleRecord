//
//  UserDBOperationManager.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "UserDBOperationManager.h"

#define DefaultBaseName @"appData.sqlite"
#define SimpleRecordDB                 @"SimpleRecordDB.sqlite"

#define CreateUserInfo               @"CREATE TABLE IF NOT EXISTS T_USERINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT NOT NULL, PASSWORLD TEXT NOT NULL, ISLOGIN TEXT NOT NULL, AVATAR TEXT NOT NULL);"
//是否存在该用户
#define ExistUser @"SELECT * FROM T_USERINFO WHERE USERNAME = '%@'"
//插入用户表数据
#define InsertToUserInfor            @"INSERT INTO T_USERINFO (USERNAME,PASSWORLD,ISLOGIN,AVATAR) VALUES ('%@','%@','%@','%@');"
//更新用户表
#define UpdateUserInfor              @"UPDATE T_USERINFO SET PASSWORLD = '%@' , ISLOGIN = '%@', AVATAR = '%@' WHERE USERNAME = %@ ;"
//删除用户表
#define DeleteUserInfor              @"DELETE FORM T_USERINFO WHERE USERNAME = %@ ;"
//加载用户 当OAUTHTOKEN 不为空的时候
#define LoadUser @"SELECT USERNAME, PASSWORLD, USERID FROM T_USERINFO WHERE ISLOGIN NOT NULL"
//用户退出
#define UserLogOut @"UPDATE USER SET ISLOGIN = NULL WHERE USERNAME = '%@'"
//创建日记表
#define CreateSecretInfo               @"CREATE TABLE IF NOT EXISTS T_SECRETINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, USERNAME TEXT NOT NULL);"
//是否存在该日记
#define ExistOneDiary @"SELECT * FROM T_SECRETINFO WHERE USERNAME = '%@', ADDTIME = '%@';"
//插入日记表数据
#define InsertToSecretInfor            @"INSERT INTO T_SECRETINFO (ADDTIME,CONTENT,USERNAME) VALUES ('%@','%@','%@');"
//更新日记表数据
#define UpdateSecretInfor              @"UPDATE T_SECRETINFO SET CONTENT = '%@' WHERE ADDTIME = '%@' AND USERNAME = '%@';"
//加载一份日记 当USERNAME 不为空的时候
#define LoadOneDiary @"SELECT CONTENT, ADDTIME, USERNAME FROM T_SECRETINFO WHERE USERNAME = '%@' AND ADDTIME = '%@'; "
//加载所有日记 当USERNAME 不为空的时候
#define LoadALLDiary @"SELECT CONTENT, ADDTIME, USERNAME FROM T_SECRETINFO WHERE USERNAME = '%@'; "
//删除日记表数据
#define DeleteSecretInfor              @"DELETE FORM T_SECRETINFO WHERE ADDTIME = '%@',USERNAME = '%@';"
//创建文章表数据
#define CreateArticleTable             @"CREATE TABLE IF NOT EXISTS T_ARTICLE (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, LASTUPDATETIME TEXT NOT NULL,USERNAME TEXT NOT NULL);"
//是否存在该文章
#define ExistOneArticle @"SELECT * FROM T_ARTICLE WHERE USERNAME = '%@', ADDTIME = '%@';"
//插入文章表数据
#define InsertToArticleTable           @"INSERT INTO T_ARTICLE (ADDTIME,CONTENT,LASTUPDATETIME,USERNAME) VALUES ('%@','%@','%@','%@');"
//更新文章表数据
#define UpdateArticleTable             @"UPDATE T_ARTICLE SET CONTENT = '%@', LASTUPDATETIME = '%@' WHERE ADDTIME = '%@' AND USERNAME = '%@' ;"
//加载一篇文章 当USERNAME 不为空的时候
#define LoadOneArticle @"SELECT CONTENT, ADDTIME, USERNAME, LASTUPDATETIME FROM T_ARTICLE WHERE USERNAME = '%@' AND ADDTIME = '%@'; "
//加载所有文章 当USERNAME 不为空的时候
#define LoadALLArticle @"SELECT CONTENT, ADDTIME, USERNAME, LASTUPDATETIME FROM T_ARTICLE WHERE USERNAME = '%@'; "
//删除文章表数据
#define DeleteArticleTable             @"DELETE FORM T_ARTICLE WHERE ADDTIME = '%@',USERNAME = '%@' ;"

@interface UserDBOperationManager()

/**
 *  默认数据库
 */
@property (nonatomic, strong) FMDatabase *defaultDataBase;
@end

@implementation UserDBOperationManager

static UserDBOperationManager *sharedInstance = nil;

/*
 获取全局的单例
 */
+ (instancetype) sharedInstance
{
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[UserDBOperationManager alloc] init];
    });
    return sharedInstance;
}
//打开的前提下
- (void)createInitTableByDatabase
{
    if ([_defaultDataBase open]) {
        if (![_defaultDataBase executeUpdate:CreateUserInfo]) {
            NSLog(@"创建用户信息表失败");
        }
        if (![_defaultDataBase executeUpdate:CreateSecretInfo]) {
            NSLog(@"创建日记存储表失败");
        }
        if (![_defaultDataBase executeUpdate:CreateArticleTable]) {
            NSLog(@"创建文章存储表失败");
        }
        [_defaultDataBase close];
    }
}
- (FMDatabase *)createDataBaseName:(NSString *)dataBaseName
{
    //APP所在路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                                                               NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    
    //往应用程序路径中添加数据库文件名称，把它们拼接起来
    NSString *dbFilePath = [documentFolderPath stringByAppendingPathComponent:dataBaseName];
    
    //没有则创建
    FMDatabase *dataBase=[FMDatabase databaseWithPath:dbFilePath];
    
    return dataBase;
}


- (void)createDefaultDataBase
{
    _defaultDataBase = [self createDataBaseName:DefaultBaseName];
    [self createInitTableByDatabase];
}
- (void)loadUser:(SRAppUserProfile *)userInfo
{
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:LoadUser];
        if(result.next)
        {
            userInfo.userName = [result stringForColumn:@"USERNAME"];
            userInfo.userIsLogin = [result stringForColumn:@"ISLOGIN"];
            userInfo.password = [result stringForColumn:@"PASSWORLD"];
            userInfo.imageData = [result stringForColumn:@"AVATAR"];
        }
    }
}
#pragma mark -存储或更新用户信息
- (BOOL)savetUserInfo:(SRAppUserProfile *)userInfo
{
    BOOL status;
    if([_defaultDataBase open])
    {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userId]];
        if (result.next) {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUserInfor,userInfo.password,userInfo.userIsLogin,userInfo.imageData,userInfo.userName]];
        }
        else
        {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToUserInfor,userInfo.userName,userInfo.password,userInfo.userIsLogin,userInfo.imageData]];
        }
        [_defaultDataBase close];
    }
    return status;
}



- (void)updateUserInfo:(SRAppUserProfile *)userInfo
{
    if ([_defaultDataBase open]) {
        if (![_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUserInfor, userInfo.password, userInfo.userIsLogin, userInfo.imageData, userInfo.userName]]) {
        }
        [_defaultDataBase close];
    }
}

- (BOOL)userLogOut:(SRAppUserProfile *)userInfo
{
    BOOL status = false;
    if([_defaultDataBase open])
    {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UserLogOut, userInfo.userName]];
    }
    return status;
}

//-------------- Diary -------------------

- (BOOL)saveDiaryInfo:(SRUserDiaryProfile *)oneDiary {
    BOOL status;
    if([_defaultDataBase open])
    {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistOneDiary, oneDiary.userName, oneDiary.addTime]];
        if (result.next) {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateSecretInfor,oneDiary.content,oneDiary.addTime,oneDiary.userName]];
        }
        else
        {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToSecretInfor,oneDiary.content,oneDiary.addTime,oneDiary.userName]];
        }
        [_defaultDataBase close];
    }
    return status;
}

- (BOOL)removeDiary:(SRUserDiaryProfile *)oneDiary {
    BOOL status = false;
    if([_defaultDataBase open])
    {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:DeleteSecretInfor, oneDiary.addTime, oneDiary.userName]];
    }
    return status;
}

- (void)loadOneDiary:(SRUserDiaryProfile *)oneDiary {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadOneDiary, oneDiary.addTime, oneDiary.userName]];
        if(result.next)
        {
            oneDiary.userName = [result stringForColumn:@"USERNAME"];
            oneDiary.addTime = [result stringForColumn:@"ADDTIME"];
            oneDiary.content = [result stringForColumn:@"CONTENT"];
        }
    }
}

- (void)loadAllDiary:(NSArray<SRUserDiaryProfile *> *) allDiary {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLDiary, allDiary[0].userName]];
        if(result.next)
        {
            for (SRUserDiaryProfile *oneDiary in allDiary) {
                oneDiary.userName = [result stringForColumn:@"USERNAME"];
                oneDiary.addTime = [result stringForColumn:@"ADDTIME"];
                oneDiary.content = [result stringForColumn:@"CONTENT"];
            }
        }
    }
}

//-------------- Articel -------------------

- (BOOL)saveArticleInfo:(SRUserArticleProfile *)oneArticle {
    BOOL status;
    if([_defaultDataBase open])
    {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistOneArticle, oneArticle.userName, oneArticle.addTime]];
        if (result.next) {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateArticleTable,oneArticle.content,oneArticle.lastUpdateTime,oneArticle.addTime,oneArticle.userName]];
        }
        else
        {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToArticleTable,oneArticle.addTime,oneArticle.content,oneArticle.lastUpdateTime,oneArticle.userName]];
        }
        [_defaultDataBase close];
    }
    return status;
}

- (BOOL)removeArticle:(SRUserArticleProfile *)oneArticle {
    BOOL status = false;
    if([_defaultDataBase open])
    {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:DeleteArticleTable, oneArticle.addTime, oneArticle.userName]];
    }
    return status;
}

- (void)loadOneArticle:(SRUserArticleProfile *)oneArticle {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadOneArticle, oneArticle.userName,oneArticle.addTime]];
        if(result.next)
        {
            oneArticle.userName = [result stringForColumn:@"USERNAME"];
            oneArticle.addTime = [result stringForColumn:@"ADDTIME"];
            oneArticle.content = [result stringForColumn:@"CONTENT"];
            oneArticle.lastUpdateTime = [result stringForColumn:@"LASTUPDATETIME"];
        }
    }
}

- (void)loadAllArticle:(NSArray<SRUserArticleProfile *> *) allArticle {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLDiary, allArticle[0].userName]];
        if(result.next)
        {
            for (SRUserArticleProfile *oneArticle in allArticle) {
                oneArticle.userName = [result stringForColumn:@"USERNAME"];
                oneArticle.addTime = [result stringForColumn:@"ADDTIME"];
                oneArticle.content = [result stringForColumn:@"CONTENT"];
                oneArticle.lastUpdateTime = [result stringForColumn:@"LASTUPDATETIME"];
            }
        }
    }
}

@end