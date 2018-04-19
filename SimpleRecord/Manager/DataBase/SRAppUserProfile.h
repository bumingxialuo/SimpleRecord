//
//  SRAppUserProfile.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/17.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRAppUserProfile : NSObject
/**
 *  用户名
 */
@property(nonatomic, copy)NSString *userName;
/**
 *  脱敏后的用户名
 */
@property(nonatomic, copy)NSString *hideUserName;
/**
 *  用户id
 */
@property(nonatomic, copy)NSString *userId;

/**
 *  头像地址
 */
@property(nonatomic, copy) NSString *imageData;

/**
 *密码
 */
@property(nonatomic, copy) NSString *password;

/**
 *登录标识
 */
@property(nonatomic, copy) NSString *userIsLogin;

/********************************登录信息********************/

/**
 *  是否登录
 */
@property(nonatomic, readonly)BOOL isLogon;



+ (instancetype)sharedInstance;

/**
 退出登录
 
 @return 成功YES 失败NO
 */
-(BOOL)cleanUp;

/**
 判断用户是否已注册

 @return 是否成功
 */
- (BOOL)judgeUserExit;

/**
 用户注册

 @return 是否成功
 */
- (BOOL)userRegister;

/**
 用户登录

 @return 是否成功
 */
- (BOOL)userLogin;

/**
 登录后修改信息

 @return 是否成功
 */
- (BOOL)save;
@end
