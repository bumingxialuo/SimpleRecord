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
        _themeColor = _themeColor ? _themeColor : [UIColor colorWithHexString:@"DFADE4"];
        _secondColor = _secondColor ? _secondColor : [UIColor colorWithHexString:@"00B2EE"];
        _thirdColor = _thirdColor ? _thirdColor : [UIColor colorWithHexString:@"9a90dc" withAlpha:0.5];
        _animationOneColor = _animationOneColor ? _animationOneColor : [UIColor colorWithHexString:@"9a7e68" withAlpha:0.5];
        _animationTwoColor = _animationTwoColor ? _animationTwoColor : [UIColor colorWithHexString:@"9a8bcf" withAlpha:0.5];
        _animationThreeColor = _animationThreeColor ? _animationThreeColor : [UIColor colorWithHexString:@"9a90dc" withAlpha:0.5];
        _animationFourColor = _animationFourColor ? _animationFourColor : [UIColor colorWithHexString:@"9a90dc" withAlpha:0];
        _highlightColor = _highlightColor ? _highlightColor : [UIColor colorWithHexString:@"A5D5E2"];
        _backgroundColor = _backgroundColor ? _backgroundColor : [UIColor colorWithHexString:@"#f5f5f5"];
        _textColor = _textColor ? _textColor : [UIColor colorWithHexString:@"#666"];
    }
    return self;
}

- (NSString *)themeColorStr {
    return [NSString stringWithFormat:@"%@",_themeColor];
}
- (NSString *)secondColorStr {
    return [NSString stringWithFormat:@"%@",_secondColor];
}
- (NSString *)thirdColorStr {
    return [NSString stringWithFormat:@"%@",_thirdColor];
}
- (NSString *)animationOneColorStr {
    return [NSString stringWithFormat:@"%@",_animationOneColor];
}
- (NSString *)backgroundColorStr {
    return [NSString stringWithFormat:@"%@",_backgroundColor];
}
- (NSString *)textColorStr {
    return [NSString stringWithFormat:@"%@",_textColor];
}
@end
