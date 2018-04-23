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

- (BOOL)insertArtcle {
    return [[UserDBOperationManager sharedInstance] insertOneArticle:self];
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

- (NSString *)findOneArticle {
    return [[UserDBOperationManager sharedInstance] loadOneArticleReturnStr:self];
}

- (void)findAllArticle  {
    
}

- (NSString *)loadLatestArticle {
    return [[UserDBOperationManager sharedInstance] loadlatestArticle:self];
}
@end
