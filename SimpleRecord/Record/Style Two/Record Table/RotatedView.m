//
//  RotatedView.m
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RotatedView.h"

@interface RotatedView()<CAAnimationDelegate>

@end

@implementation RotatedView

- (void)addBackViewWithHeight:(CGFloat)height color:(UIColor *)color
{
    RotatedView *view = [[RotatedView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = color;
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    view.layer.transform = [self rotateTransform3d];
    //禁用autoresizing
    view.translatesAutoresizingMaskIntoConstraints = false;
    self.backView = view;
    [self addSubview:view];
    
    //添加约束
    
    NSLayoutConstraint *viewConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
    [view addConstraint:viewConstraint];
    
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.bounds.size.height - height + height / 2],
                           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]
                           ]];
    
}

- (void)foldingAnimationWithTimingFunctionString:(NSString *)timing from:(CGFloat)from to:(CGFloat)to duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay hidden:(BOOL)hidden {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    rotateAnimation.fromValue = @(from);
    rotateAnimation.toValue = @(to);
    rotateAnimation.duration = duration;
    rotateAnimation.delegate = self;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.beginTime = CACurrentMediaTime() + delay;
    
    self.hiddenAfterAnimation = hidden;
    [self.layer addAnimation:rotateAnimation forKey:@"rotation.x"];
}

- (CATransform3D)rotateTransform3d
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}

- (void)rotatedXByAngle:(CGFloat)angle
{
    CATransform3D allTransform = CATransform3DIdentity;
    CATransform3D rotateTransform = CATransform3DMakeRotation(angle, 1, 0, 0);
    //叠加效果
    allTransform = CATransform3DConcat(allTransform, rotateTransform);
    allTransform = CATransform3DConcat(allTransform, [self rotateTransform3d]);
    self.layer.transform = allTransform;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    //缓存layer为bitmap
    self.layer.shouldRasterize = YES;
    self.alpha = 1;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.hiddenAfterAnimation) self.alpha = 0;
    
    [self.layer removeAllAnimations];
    self.layer.shouldRasterize = NO;
    [self rotatedXByAngle:0.f];
}

@end
