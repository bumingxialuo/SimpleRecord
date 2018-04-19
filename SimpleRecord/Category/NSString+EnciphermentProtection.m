//
//  NSString+EnciphermentProtection.m
//  SimpleRecord
//
//  Created by xia on 2018/4/19.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "NSString+EnciphermentProtection.h"

@implementation NSString (EnciphermentProtection)
+ (NSString *)md5To32bit:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr),digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}


/*  判断用户输入的密码是否符合规范，符合规范的密码要求：
 * 长度大于8位
 * 密码中必须同时包含数字和字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass {
    BOOL result = false;
    if ([pass length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
@end
