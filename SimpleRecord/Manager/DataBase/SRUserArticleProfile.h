//
//  SRUserArticleProfile.h
//  SimpleRecord
//
//  Created by xia on 2018/4/18.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRUserArticleProfile : NSObject

@property(nonatomic, copy) NSString *addTime;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *lastUpdateTime;

@property(nonatomic, copy) NSString *userName;

+ (instancetype)sharedInstance;

- (BOOL)saveArticle;

- (BOOL)removeArticle;

- (void)findOneArticle ;

- (void)findAllArticle ;

@end
