//
//  ChangeRecordStyleCustomView.m
//  SimpleRecord
//
//  Created by xia on 2018/3/14.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChangeRecordStyleCustomView.h"
#import "AppSkinColorManger.h"
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface ChangeRecordStyleCustomView()
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) UIButton *diaryRecordButton;
@property(nonatomic, strong) UIButton *articleRecordButton;
@end

@implementation ChangeRecordStyleCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    _addButton = [[UIButton alloc] init];
    [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    _diaryRecordButton = [[UIButton alloc] init];
    [_diaryRecordButton setBackgroundColor:[UIColor flatSkyBlueColor]];
    [_diaryRecordButton setImage:[UIImage imageNamed:@"diary"] forState:UIControlStateNormal];
    _diaryRecordButton.hidden = YES;
    [self addSubview:_diaryRecordButton];
    [_diaryRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(64);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    _articleRecordButton = [[UIButton alloc] init];
    [_articleRecordButton setBackgroundColor:[UIColor flatPurpleColor]];
    [_articleRecordButton setImage:[UIImage imageNamed:@"article"] forState:UIControlStateNormal];
    [self addSubview:_articleRecordButton];
    _articleRecordButton.hidden = YES;
    [_articleRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.left.mas_equalTo(_diaryRecordButton.mas_right).offset(64);
    }];
}

- (void)addButtonClick:(UIButton *)sender {
    [self addButtonStartAnimation];
    [self recordButtonStartAnimation];
    if (_viewDelegate && [_viewDelegate respondsToSelector:@selector(clickAddButton)]) {
        [_viewDelegate clickAddButton];
    }
}

- (void)addButtonStartAnimation {
    //唯一
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width * 0.8, self.frame.size.height / 2)];
    anima.duration = 1.f;
    [_addButton.layer addAnimation:anima forKey:@"positionAnimation"];
    
    //缩放
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    anima2.toValue = [NSNumber numberWithFloat:0.68f];
    anima2.duration = 1.0f;
    [_addButton.layer addAnimation:anima2 forKey:@"scaleAnimation"];
    
    //旋转
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima3.toValue = [NSNumber numberWithFloat:M_PI*1.5];
    anima3.duration = 1.0f;
    [_addButton.layer addAnimation:anima3 forKey:@"rotateAnimation"];
    
    //透明度
    CABasicAnimation *anima4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima4.fromValue = [NSNumber numberWithFloat:1.0f];
    anima4.toValue = [NSNumber numberWithFloat:0.1f];
    anima4.duration = 1.0f;
    [_diaryRecordButton.layer addAnimation:anima4 forKey:@"opacityAniamtion"];
    
    _addButton.frame = CGRectMake(self.frame.size.width * 0.8, self.frame.size.height / 2, 64*0.3, 64*0.3);
    [_addButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    CABasicAnimation *anima5 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima5.fromValue = [NSNumber numberWithFloat:0.1f];
    anima5.toValue = [NSNumber numberWithFloat:1.0f];
    anima5.duration = 2.0f;
    [_diaryRecordButton.layer addAnimation:anima5 forKey:@"opacityAniamtion"];
}

- (void)recordButtonStartAnimation {
    _diaryRecordButton.hidden = NO;
    _articleRecordButton.hidden = NO;
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:0.0f];
    anima.toValue = [NSNumber numberWithFloat:1.0f];
    anima.duration = 3.0f;
    [_diaryRecordButton.layer addAnimation:anima forKey:@"opacityAniamtion"];
    [_articleRecordButton.layer addAnimation:anima forKey:@"opacityAniamtion"];
}

@end
