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

#define CreateUserInfo               @"CREATE TABLE IF NOT EXISTS T_USERINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT NOT NULL, PASSWORLD TEXT NOT NULL);"
//是否存在该用户
#define ExistUser @"SELECT * FROM T_USERINFO WHERE USERID = '%@'"
//插入用户表数据
#define InsertToUserInfor            @"INSERT INTO T_USERINFO (USERNAME,PASSWORLD) VALUES ('%@','%@');"
//更新用户表
#define UpdateUserInfor              @"UPDATE T_USERINFO SET USERNAME = '%@' , PASSWORLD = '%@' WHERE id = %@ ;"
//删除用户表
#define DeleteUserInfor              @"DELETE FORM T_USERINFO WHERE id = %@ ;"
//加载用户 当OAUTHTOKEN 不为空的时候
#define LoadUser @"SELECT USERNAME, PASSWORLD,USERID FROM USER WHERE OAUTHTOKEN NOT NULL"
//用户退出
#define UserLogOut @"UPDATE USER SET USERNAME = NULL, PASSWORLD = NULL WHERE USERID = '%@'"
//创建日记表
#define CreateSecretInfo               @"CREATE TABLE IF NOT EXISTS T_SECRETINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, NOTEID TEXT NOT NULL);"
//插入日记表数据
#define InsertToSecretInfor            @"INSERT INTO T_SECRETINFO (ADDTIME,CONTENT,NOTEID) VALUES ('%@','%@','%@');"
//更新日记表数据
#define UpdateSecretInfor              @"UPDATE T_SECRETINFO SET CONTENT = '%@' WHERE ADDTIME = '%@',NOTEID = '%@';"
//删除日记表数据
#define DeleteSecretInfor              @"DELETE FORM T_SECRETINFO WHERE ADDTIME = '%@',NOTEID = '%@';"
//创建文章表数据
#define CreateArticleTable             @"CREATE TABLE IF NOT EXISTS T_ARTICLE (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, LASTUPDATETIME TEXT NOT NULL,USERID TEXT NOT NULL);"
//插入文章表数据
#define InsertToArticleTable           @"INSERT INTO T_ARTICLE (ADDTIME,CONTENT,LASTUPDATETIME,USERID) VALUES ('%@','%@','%@');"
//更新文章表数据
#define UpdateArticleTable             @"UPDATE T_ARTICLE SET CONTENT = '%@', LASTUPDATETIME = '%@' WHERE id = %@,USERID = '%@' ;"
//删除文章表数据
#define DeleteArticleTable             @"DELETE FORM T_ARTICLE WHERE id = %@,USERID = '%@' ;"

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

#pragma mark -存储或更新用户信息
- (BOOL)savetUserInfo:(SRAppUserProfile *)userInfo
{
    BOOL status;
    if([_defaultDataBase open])
    {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userId]];
        if (result.next) {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUserInfor,userInfo.userName,userInfo.password,userInfo.userId]];
        }
        else
        {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToUserInfor,userInfo.userName,userInfo.password]];
        }
        [_defaultDataBase close];
    }
    return status;
}


//- (void)updateUserInfo:(SRAppUserProfile *)userInfo gesturePWD:(NSString *)gesturePwd
//{
//    if ([_defaultDataBase open]) {
//        if (![_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateGuesturePWD, gesturePwd, userInfo.userId]]) {
//        }
//        [_defaultDataBase close];
//    }
//}

- (void)updateUserInfo:(SRAppUserProfile *)userInfo
{
    if ([_defaultDataBase open]) {
        if (![_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUserInfor, userInfo.userName, userInfo.password, userInfo.password]]) {
        }
        [_defaultDataBase close];
    }
}

//- (NSString *)getGesturePWD:(RdAppUserProfile *)userInfo
//{
//    NSString *temp = @"";
//    if ([_defaultDataBase open]) {
//        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:GetGuesturePWD, userInfo.userId]];
//        if (result.next) {
//            temp = [result stringForColumn:@"GESTUREPWD"];
//        }
//        [_defaultDataBase close];
//    }
//    return temp;
//}

//- (BOOL)checkUserInfo:(RdAppUserProfile *)userInfo gesturePWD:(NSString *)gesturePwd
//{
//    return [gesturePwd isEqualToString:[self getGesturePWD:userInfo]];
//}

//- (void)loadUser:(RdAppUserProfile *)userInfo
//{
//    if ([_defaultDataBase open]) {
//        FMResultSet *result=[_defaultDataBase executeQuery:LoadUser];
//        if(result.next)
//        {
//            userInfo.hideUserName = [result stringForColumn:@"HIDEUSERNAME"];
//            userInfo.userName = [result stringForColumn:@"USERNAME"];
//            userInfo.oauthToken = [result stringForColumn:@"OAUTHTOKEN"];
//            userInfo.userId = [result stringForColumn:@"USERID"];
//            userInfo.refreshToken = [result stringForColumn:@"REFRESHTOKEN"];
//            userInfo.avatarPath = [result stringForColumn:@"AVATARPHOTO"];
//            //            userInfo.expiresIn = [NSString stringWithFormat:@"%f", [result stringForColumn:@"EXPIRESIN"] ];
//        }
//    }
//}

- (BOOL)userLogOut:(SRAppUserProfile *)userInfo
{
    BOOL status = false;
    if([_defaultDataBase open])
    {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UserLogOut, userInfo.userId]];
    }
    return status;
}

@end
