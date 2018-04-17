//
//  SRAppUserProfile.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/17.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "SRAppUserProfile.h"
#import "UserDBOperationManager.h"

@implementation SRAppUserProfile
static  SRAppUserProfile *sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SRAppUserProfile alloc] init];
//        [sharedInstance load];
    });
    return sharedInstance;
}

-(BOOL)cleanUp
{
    BOOL reslut = [[UserDBOperationManager sharedInstance] userLogOut:self];
    _userId = @"";
    _userName = @"";
    _hideUserName = @"";
    _imageData = @"";
    return reslut;
}
-(NSString *)hideUserName{
    NSString *tmpUserName;
    if (_userName.length == 11) {
        tmpUserName = [_userName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return tmpUserName;
    }
    else{
        return _userName;
    }
}

- (BOOL)save
{
    return  [[UserDBOperationManager sharedInstance] savetUserInfo:self];
}

//- (void)load
//{
//    [[UserDBOperationManager sharedInstance] loadUser:self];
//}


-(BOOL)isLogon
{
//    return _oauthToken.length > 0;
    return NO;
}


//- (BOOL)checkGesture:(NSString *)pwd
//{
//    return [[UserDBOperationManager sharedInstance] checkUserInfo:self gesturePWD:pwd];
//}
//
//- (BOOL)isOpenTouchID
//{
//    return [[UserDBOperationManager sharedInstance] userIsOpenTouchID:self];
//}
//
//- (void)setOpenTouchID:(BOOL)open
//{
//    [[UserDBOperationManager sharedInstance] updateUserInfo:self openTouchID:open];
//}
//- (void)saveGesture:(NSString *)gesturePwd
//{
//    return [[UserDBOperationManager sharedInstance] updateUserInfo:self gesturePWD:gesturePwd];
//}
//
//- (BOOL)hasSetGesture
//{
//    return [[UserDBOperationManager sharedInstance] getGesturePWD:self].length > 0;
//}


@end
