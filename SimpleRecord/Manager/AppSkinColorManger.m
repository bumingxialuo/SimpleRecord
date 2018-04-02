//
//  AppSkinColorManger.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "AppSkinColorManger.h"
#import <ChameleonFramework/Chameleon.h>

@implementation AppSkinColorManger

+ (instancetype)sharedInstance {
    static AppSkinColorManger *_sharedIntace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedIntace = [[self alloc] init];
    });
    return _sharedIntace;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _themeColor = [UIColor colorWithHexString:@"DFADE4"];
        _secondColor = [UIColor colorWithHexString:@"00B2EE"];
        _highlightColor = [UIColor colorWithHexString:@"A5D5E2"];
        _backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        _textColor = [UIColor colorWithHexString:@"#666"];
    }
    return self;
}

@end
