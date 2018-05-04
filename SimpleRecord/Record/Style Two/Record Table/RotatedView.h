//
//  RotatedView.h
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotatedView : UIView
@property (nonatomic, assign) BOOL hiddenAfterAnimation;
@property (nonatomic, strong) RotatedView *backView;

- (void)addBackViewWithHeight:(CGFloat)height color:(UIColor *)color;

- (void)foldingAnimationWithTimingFunctionString:(NSString *)timing from:(CGFloat)from to:(CGFloat)to duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay hidden:(BOOL)hidden;

- (CATransform3D)rotateTransform3d;
@end
