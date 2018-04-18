//
//  MineTableHeadView.m
//  SimpleRecord
//
//  Created by xia on 2018/3/30.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "MineTableHeadView.h"
#import <Masonry.h>
#import "Macro.h"
#import "AppSkinColorManger.h"
#import "RippleAnimationView.h"

@interface MineTableHeadView()
//@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *avatar;
@end

@implementation MineTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
//    _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personCenterBG"]];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 100)];
    _bgView.backgroundColor = [AppSkinColorManger sharedInstance].themeColor;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *boderPath = [UIBezierPath bezierPath];
    
    maskLayer.frame = _bgView.bounds;
    [boderPath moveToPoint:CGPointMake(0, 40)];
    [boderPath addQuadCurveToPoint:CGPointMake(WIDTHOFSCREEN, 40) controlPoint:CGPointMake(WIDTHOFSCREEN * 0.5, 180)];
    [boderPath addLineToPoint:CGPointMake(WIDTHOFSCREEN, 0)];
    [boderPath addLineToPoint:CGPointMake(0, 0)];
    [boderPath addLineToPoint:CGPointMake(0, 40)];
    maskLayer.path = boderPath.CGPath;
    [_bgView.layer setMask:maskLayer];
    
    RippleAnimationView *animationView = [[RippleAnimationView alloc] initWithFrame:CGRectMake((WIDTHOFSCREEN - 168)*0.5, (180-168)*0.5, 84, 84) animationType:AnimationTypeWithBackground];
    _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头像 女孩"]];
    _avatar.frame = CGRectMake((WIDTHOFSCREEN - 168)*0.5, (180-168)*0.5, 84, 84);
    _avatar.center = CGPointMake(WIDTHOFSCREEN*0.5, 90);
    _avatar.layer.cornerRadius = 42;
    _avatar.layer.masksToBounds = YES;
    _avatar.userInteractionEnabled = YES;
    animationView.center = _avatar.center;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTouchDoLogin)];
    [_avatar addGestureRecognizer:tap];
    [self addSubview:_bgView];
    [self addSubview:animationView];
    [self addSubview:_avatar];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)avatarTouchDoLogin {
    if (_headViewDelegate && [_headViewDelegate respondsToSelector:@selector(mineTableHeadViewDoLogin)]) {
        [_headViewDelegate mineTableHeadViewDoLogin];
    }
}

@end
