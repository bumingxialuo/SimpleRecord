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
        [sharedInstance load];
    });
    return sharedInstance;
}

- (void)load
{
    [[UserDBOperationManager sharedInstance] loadUser:self];
}

-(BOOL)cleanUp
{
    BOOL reslut = [[UserDBOperationManager sharedInstance] userLogOut:self];
    _userId = @"";
    _userName = @"";
    _hideUserName = @"";
    _imageData = @"";
    _userIsLogin = @"";
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

- (BOOL)judgeUserExit {
    return [[UserDBOperationManager sharedInstance] isExitUser:self];
}

- (BOOL)userLogin {
    return [[UserDBOperationManager sharedInstance] loginUser:self];
}

- (BOOL)userRegister {
    return [[UserDBOperationManager sharedInstance] insertUserInfo:self];
}
-(BOOL)isLogon
{
    return [_userIsLogin isEqualToString:@"10"];
}



@end
