//
//  SRUserArticleProfile.m
//  SimpleRecord
//
//  Created by xia on 2018/4/18.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "SRUserArticleProfile.h"
#import "UserDBOperationManager.h"
#import "SRAppUserProfile.h"

@implementation SRUserArticleProfile
static  SRUserArticleProfile *sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SRUserArticleProfile alloc] init];
    });
    return sharedInstance;
}

- (BOOL)saveArticle {
    return [[UserDBOperationManager sharedInstance] saveArticleInfo:self];
}

- (BOOL)removeArticle {
    BOOL reslut = [[UserDBOperationManager sharedInstance] removeArticle:self];
    _userName = @"";
    _content = @"";
    _addTime = @"";
    return reslut;
}

- (void)findOneArticle {
    [[UserDBOperationManager sharedInstance] loadOneArticle:self];
}

- (void)findAllArticle  {
    
}
@end
