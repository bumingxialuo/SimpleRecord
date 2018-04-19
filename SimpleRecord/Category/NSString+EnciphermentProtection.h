//
//  NSString+EnciphermentProtection.h
//  SimpleRecord
//
//  Created by xia on 2018/4/19.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (EnciphermentProtection)

/**
 MD5加密

 @param str 待加密字符串
 @return 处理后的字符串
 */
+ (NSString *)md5To32bit:(NSString *)str;

/**
 判断密码是否符合规范

 @param pass 密码串
 @return 结果
 */
+(BOOL)judgePassWordLegal:(NSString *)pass;

@end
