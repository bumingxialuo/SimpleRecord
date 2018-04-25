//
//  UserDBOperationManager.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "UserDBOperationManager.h"

#define DefaultBaseName              @"appData.sqlite"
#define SimpleRecordDB               @"SimpleRecordDB.sqlite"

#define CreateColorConfig            @"CREATE TABLE IF NOT EXISTS T_COLORCONFIG (id INTEGER PRIMARY KEY AUTOINCREMENT , THEMECOLR TEXT NOT NULL , SECONDCOLOR TEXT NOT NULL, THRIDCOLOR TEXT NOT NULL, ANIMATIONCOLOR TEXT NOT NULL, BACKGROUNDCOLOR TEXT NOT NULL, TEXTONE TEXT ,TEXTTWO TEXT, TEXTTHREE TEXT);"

#define InsertColorConfig            @"INSERT INTO T_COLORCONFIG (THEMECOLR,SECONDCOLOR,THRIDCOLOR,ANIMATIONCOLOR,BACKGROUNDCOLOR,TEXTONE,TEXTTWO,TEXTTHREE) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@');"

#define SaveColorConfig              @"UPDATE T_COLORCONFIG SET THEMECOLR = '%@',SECONDCOLOR = '%@',THRIDCOLOR = '%@',ANIMATIONCOLOR = '%@',BACKGROUNDCOLOR = '%@', TEXTONE = '%@',  TEXTTWO = '%@', TEXTTHREE = '%@' WHRER id = 1;"

#define LoadColor                    @"SELECT * FROM T_COLORCONFIG WHERE id = 1;"

#define CreateUserInfo               @"CREATE TABLE IF NOT EXISTS T_USERINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT NOT NULL, PASSWORLD TEXT NOT NULL, ISLOGIN TEXT, AVATAR TEXT);"
//是否存在该用户
#define ExistUser                    @"SELECT * FROM T_USERINFO WHERE USERNAME = '%@';"
//插入用户表数据
#define InsertToUserInfor            @"INSERT INTO T_USERINFO (USERNAME,PASSWORLD,ISLOGIN,AVATAR) VALUES ('%@','%@','%@','%@');"
//更新用户登录信息
#define UpdateUserLogin              @"UPDATE T_USERINFO SET ISLOGIN = '%@' WHERE USERNAME = '%@' AND PASSWORLD = '%@';"
//登录后修改
#define UpdateUser                   @"UPDATE T_USERINFO SET PASSWORLD = '%@', AVATAR = '%@' WHERE USERNAME = '%@' AND ISLOGIN = '%@';"
//删除用户表
#define DeleteUserInfor              @"DELETE FORM T_USERINFO WHERE USERNAME = %@ ;"
//加载用户 当OAUTHTOKEN 不为空的时候
#define LoadUser                     @"SELECT USERNAME,ISLOGIN, PASSWORLD, AVATAR FROM T_USERINFO WHERE ISLOGIN = '10';"
//用户退出
#define UserLogOut                   @"UPDATE T_USERINFO SET ISLOGIN = NULL WHERE USERNAME = '%@';"
//创建日记表
#define CreateSecretInfo             @"CREATE TABLE IF NOT EXISTS T_SECRETINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, USERNAME TEXT NOT NULL);"
//是否存在该日记
#define ExistOneDiary                @"SELECT * FROM T_SECRETINFO WHERE USERNAME = '%@' AND ADDTIME = '%@';"
//插入日记表数据
#define InsertToSecretInfor          @"INSERT INTO T_SECRETINFO (ADDTIME,CONTENT,USERNAME) VALUES ('%@','%@','%@');"
//更新日记表数据
#define UpdateSecretInfor            @"UPDATE T_SECRETINFO SET CONTENT = '%@' WHERE ADDTIME = '%@' AND USERNAME = '%@';"
//加载一份日记 当USERNAME 不为空的时候
#define LoadOneDiary                 @"SELECT CONTENT, ADDTIME, USERNAME FROM T_SECRETINFO WHERE USERNAME = '%@' AND ADDTIME = '%@'; "
//加载所有日记 当USERNAME 不为空的时候
#define LoadALLDiary                 @"SELECT CONTENT, ADDTIME, USERNAME FROM T_SECRETINFO WHERE USERNAME = '%@'; "
//删除日记表数据
#define DeleteSecretInfor            @"DELETE FORM T_SECRETINFO WHERE ADDTIME = '%@',USERNAME = '%@';"
//创建文章表数据
#define CreateArticleTable           @"CREATE TABLE IF NOT EXISTS T_ARTICLE (id INTEGER PRIMARY KEY AUTOINCREMENT, ADDTIME TEXT NOT NULL, CONTENT TEXT NOT NULL, LASTUPDATETIME TEXT NOT NULL,TITLE TEXT NOT NULL,USERNAME TEXT NOT NULL,MODIFYTIME TEXT);"
//插入文章表数据
#define InsertToArticleTable         @"INSERT INTO T_ARTICLE (ADDTIME,CONTENT,LASTUPDATETIME,TITLE,USERNAME,MODIFYTIME) VALUES ('%@','%@','%@','%@','%@','%@');"
//更新文章表数据
#define UpdateArticleTable           @"UPDATE T_ARTICLE SET CONTENT = '%@', LASTUPDATETIME = '%@', MODIFYTIME = '%@',TITLE = '%@'  WHERE USERNAME = '%@' AND id = '%@';"
//加载一篇文章 当USERNAME 不为空的时候
#define LoadOneArticle               @"SELECT * FROM T_ARTICLE WHERE USERNAME = '%@' AND id = '%@'; "
//加载所有文章 当USERNAME 不为空的时候
#define LoadALLArticle               @"SELECT * FROM T_ARTICLE WHERE USERNAME = '%@'; "
//删除文章表数据
#define DeleteArticleTable           @"DELETE FORM T_ARTICLE WHERE id = '%@' ;"

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
//        if (![_defaultDataBase executeUpdate:CreateColorConfig]) {
//            NSLog(@"创建颜色存储表失败");
//        }
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
- (BOOL)loadColorConfig:(AppSkinColorManger *)color {
    BOOL states = false;
    if ([_defaultDataBase open]) {
        FMResultSet *result = [_defaultDataBase executeQuery:LoadUser];
        if (result.next) {
            states = YES;
        }
        states = false;
    }
    return states;
}

- (BOOL)saveColorConfig:(AppSkinColorManger *)color {
    BOOL states = false;
    if ([_defaultDataBase open]) {
        FMResultSet *result = [_defaultDataBase executeQuery:LoadUser];
        if (result.next) {
//            states = [_defaultDataBase executeUpdate:[NSString stringWithFormat:SaveColorConfig,color.themeColor]];
        } else {
//            states = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertColorConfig]];
        }
    }
    return states;
}
#pragma mark -存储或更新用户信息
- (BOOL)savetUserInfo:(SRAppUserProfile *)userInfo
{
    BOOL status = NO;
    if([_defaultDataBase open])
    {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
        if (result.next) {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUser,userInfo.password,userInfo.imageData,userInfo.userName,userInfo.userIsLogin]];
        }
        FMResultSet *result2 = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
        while (result2.next) {

            NSString *str0 = [result2 stringForColumnIndex:0];
            NSString *str1 = [result2 stringForColumnIndex:1];
            NSString *str2 = [result2 stringForColumnIndex:2];
            NSString *str3 = [result2 stringForColumnIndex:3];
            NSString *str4 = [result2 stringForColumnIndex:4];
            NSLog(@"%@,%@,%@,%@,%@",str0,str1,str2,str3,str4);

        }
        
        [_defaultDataBase close];
    }
    return status;
}

- (BOOL)insertUserInfo:(SRAppUserProfile *)userInfo {
    BOOL status;
    if([_defaultDataBase open])
    {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
        if (result.next) {
            
            status = NO;
        }
        else
        {
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToUserInfor,userInfo.userName,userInfo.password,userInfo.userIsLogin,userInfo.imageData]];
        }
        [_defaultDataBase close];
    }
    return status;
}

- (BOOL)isExitUser:(SRAppUserProfile *)userInfo {
    BOOL states = false;
    if ([_defaultDataBase open]) {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
        if (result.next) {
            states = YES;
        }
        [_defaultDataBase close];
    }
    return states;
}

- (BOOL)loginUser:(SRAppUserProfile *)userInfo {
     BOOL state = NO;
    if ([_defaultDataBase open]) {
        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
        while (result.next) {
            state = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUserLogin,userInfo.userIsLogin,userInfo.userName,userInfo.password]];
        }
        FMResultSet *result2 = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
        if (result2.next) {
            NSString *str0 = [result2 stringForColumn:@"ISLOGIN"];
            if ([str0 isEqualToString:@"10"]) {
                state = YES;
            } else {
                state = NO;
            }
        }
        
    }
    
    return state;
}

- (void)updateUserInfo:(SRAppUserProfile *)userInfo
{
    if ([_defaultDataBase open]) {
        if (![_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateUser,userInfo.password, userInfo.imageData, userInfo.userName, userInfo.userIsLogin]]) {
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
        
//        FMResultSet *result = [_defaultDataBase executeQuery:[NSString stringWithFormat:ExistUser, userInfo.userName]];
//        while (result.next) {
//
//            NSString *str0 = [result stringForColumnIndex:0];
//            NSString *str1 = [result stringForColumnIndex:1];
//            NSString *str2 = [result stringForColumnIndex:2];
//            NSString *str3 = [result stringForColumnIndex:3];
//            NSString *str4 = [result stringForColumnIndex:4];
//            NSLog(@"%@,%@,%@,%@,%@",str0,str1,str2,str3,str4);
//        
//        }
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
            status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToSecretInfor,oneDiary.addTime,oneDiary.content,oneDiary.userName]];
        }
        FMResultSet *result2 = [_defaultDataBase executeQuery:@"select * from T_SECRETINFO"];
        NSMutableDictionary *dic = [NSMutableDictionary new];
        while (result2.next) {
            NSString *str = [result2 stringForColumnIndex:0];
            NSString *str1 = [result2 stringForColumnIndex:1];
            NSString *str2 = [result2 stringForColumnIndex:2];
            NSString *str3 = [result2 stringForColumnIndex:3];
            dic[str1] = str2;
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

- (NSString *)loadOneDiaryReturnStr:(SRUserDiaryProfile *)oneDiary {
    if ([_defaultDataBase open]) {
        FMResultSet *resultSet=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadOneDiary, oneDiary.userName, oneDiary.addTime]];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        while (resultSet.next) {
            NSString *content = [resultSet stringForColumn:@"CONTENT"];
            NSString *addTime = [resultSet stringForColumn:@"ADDTIME"];
            if (content && addTime) {
                dict[@"addTime"] = addTime;
                dict[@"content"] = content;
            }
            
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
        if (!jsonData) {
            return @"";
        }
        
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return @"";
}

- (void)loadAllDiary:(NSArray<SRUserDiaryProfile *> *) allDiary {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLDiary, allDiary[0].userName]];
        NSMutableDictionary *dic = [NSMutableDictionary new];
        while (result.next) {
            NSString *content = [result stringForColumn:@"CONTENT"];
            NSString *addTime = [result stringForColumn:@"ADDTIME"];
            if (content && addTime) {
                dic[@"addTime"] = addTime;
                dic[@"content"] = content;
            }
        }
    }
}

- (NSString *)loadAllDiaryReturnStr:(SRUserDiaryProfile *)oneDiary {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLDiary, oneDiary.userName]];
        NSMutableArray *array = [NSMutableArray new];
        
        while (result.next)
        {
            NSMutableDictionary *muta = [NSMutableDictionary new];
            NSString *diaryId = [result stringForColumn:@"id"];
            NSString *content = [result stringForColumn:@"CONTENT"];
            NSString *addTime = [result stringForColumn:@"ADDTIME"];
           
            muta[@"content"] = content;
            muta[@"addTime"] = addTime;
            [array addObject:muta];
        }
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"list"] = array;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
        if (!jsonData) {
            return @"";
        }
        
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return @"";
}

//-------------- Articel -------------------

- (BOOL)insertOneArticle:(SRUserArticleProfile *)oneArticle {
    BOOL status= false;
    if([_defaultDataBase open]) {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:InsertToArticleTable,oneArticle.addTime,oneArticle.content,oneArticle.lastUpdateTime,oneArticle.title,oneArticle.userName,oneArticle.modifyNum]];
        [_defaultDataBase close];
    }
    return status;
}
    

- (BOOL)saveArticleInfo:(SRUserArticleProfile *)oneArticle {
    BOOL status = false;
    if([_defaultDataBase open])
    {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:UpdateArticleTable,oneArticle.content,oneArticle.lastUpdateTime,oneArticle.modifyNum,oneArticle.title,oneArticle.userName,oneArticle.articleId]];
        [_defaultDataBase close];
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLArticle, oneArticle.userName]];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        while (result.next) {
            NSString *articleId = [result stringForColumn:@"id"];
            NSString *content = [result stringForColumn:@"CONTENT"];
            NSString *addTime = [result stringForColumn:@"ADDTIME"];
            NSString *updateTime = [result stringForColumn:@"LASTUPDATETIME"];
            NSString *modifyNum = [result stringForColumn:@"MODIFYTIME"];
            NSString *title = [result stringForColumn:@"TITLE"];
            if (content && addTime) {
                dict[@"articleId"] = articleId;
                dict[@"addTime"] = addTime;
                dict[@"content"] = content;
                dict[@"updateTime"] = updateTime;
                dict[@"modifyNum"] = modifyNum;
                dict[@"title"] = title;
            }
        }
    }
    return status;
}

- (BOOL)removeArticle:(SRUserArticleProfile *)oneArticle {
    BOOL status = false;
    if([_defaultDataBase open])
    {
        status = [_defaultDataBase executeUpdate:[NSString stringWithFormat:DeleteArticleTable, oneArticle.articleId]];
    }
    return status;
}

- (NSString *)loadOneArticleReturnStr:(SRUserArticleProfile *)oneArticle {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadOneArticle, oneArticle.userName,oneArticle.articleId]];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        while (result.next) {
            NSString *articleId = [result stringForColumn:@"id"];
            NSString *content = [result stringForColumn:@"CONTENT"];
            NSString *addTime = [result stringForColumn:@"ADDTIME"];
            NSString *updateTime = [result stringForColumn:@"LASTUPDATETIME"];
            NSString *modifyNum = [result stringForColumn:@"MODIFYTIME"];
            NSString *title = [result stringForColumn:@"TITLE"];
            oneArticle.articleId = articleId;
            oneArticle.content = content;
            oneArticle.addTime = addTime;
            oneArticle.lastUpdateTime = updateTime;
            oneArticle.modifyNum = modifyNum;
            oneArticle.title = title;
            if (content && addTime) {
                dict[@"articleId"] = articleId;
                dict[@"addTime"] = addTime;
                dict[@"content"] = content;
                dict[@"updateTime"] = updateTime;
                dict[@"modifyNum"] = modifyNum;
                dict[@"title"] = title;
            }
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
        if (!jsonData) {
            return @"";
        }
        
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return @"";
}

- (NSString *)loadlatestArticle:(SRUserArticleProfile *)oneArticle {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLArticle, oneArticle.userName]];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        while (result.next) {
            NSString *articleId = [result stringForColumn:@"id"];
            NSString *content = [result stringForColumn:@"CONTENT"];
            NSString *addTime = [result stringForColumn:@"ADDTIME"];
            NSString *updateTime = [result stringForColumn:@"LASTUPDATETIME"];
            NSString *modifyNum = [result stringForColumn:@"MODIFYTIME"];
            NSString *title = [result stringForColumn:@"TITLE"];
            oneArticle.articleId = articleId;
            oneArticle.content = content;
            oneArticle.addTime = addTime;
            oneArticle.lastUpdateTime = updateTime;
            oneArticle.modifyNum = modifyNum;
            oneArticle.title = title;
            if (content && addTime) {
                dict[@"articleId"] = articleId;
                dict[@"addTime"] = addTime;
                dict[@"content"] = content;
                dict[@"updateTime"] = updateTime;
                dict[@"modifyNum"] = modifyNum;
                dict[@"title"] = title;
            }
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
        if (!jsonData) {
            return @"";
        }
        
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return @"";
}
- (NSString *)loadAllArticle:(SRUserArticleProfile *)oneArticle {
    if ([_defaultDataBase open]) {
        FMResultSet *result=[_defaultDataBase executeQuery:[NSString stringWithFormat:LoadALLArticle, oneArticle.userName]];
        NSMutableArray *array = [NSMutableArray new];
        
        while (result.next)
        {
            NSMutableDictionary *muta = [NSMutableDictionary new];
            NSString *articleId = [result stringForColumn:@"id"];
            NSString *content = [result stringForColumn:@"CONTENT"];
            NSString *addTime = [result stringForColumn:@"ADDTIME"];
            NSString *updateTime = [result stringForColumn:@"LASTUPDATETIME"];
            NSString *modifyNum = [result stringForColumn:@"MODIFYTIME"];
            NSString *title = [result stringForColumn:@"TITLE"];
            muta[@"articleId"] = articleId;
            muta[@"content"] = content;
            muta[@"addTime"] = addTime;
            muta[@"updateTime"] = updateTime;
            muta[@"modifyNum"] = modifyNum;
            muta[@"title"] = title;
            [array addObject:muta];
        }
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"list"] = array;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
        if (!jsonData) {
            return @"";
        }
        
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return @"";
}


@end
