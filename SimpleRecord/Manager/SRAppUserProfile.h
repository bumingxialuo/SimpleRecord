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

- (BOOL)save;

//- (BOOL)checkGesture:(NSString *)pwd;

//- (void)saveGesture:(NSString *)gesturePwd;

//- (BOOL)hasSetGesture;

@end
