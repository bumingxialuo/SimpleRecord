//
//  AppSkinColorManger.h
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppSkinColorManger : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic,strong) UIColor *themeColor;

@property(nonatomic,strong) UIColor *secondColor;

@property(nonatomic,strong) UIColor *thirdColor;

@property(nonatomic,strong) UIColor *animationOneColor;

@property(nonatomic,strong) UIColor *animationTwoColor;

@property(nonatomic,strong) UIColor *animationThreeColor;

@property(nonatomic,strong) UIColor *animationFourColor;

@property(nonatomic,strong) UIColor *highlightColor;

@property(nonatomic,strong) UIColor *backgroundColor;

@property(nonatomic,strong) UIColor *textColor;

@end
