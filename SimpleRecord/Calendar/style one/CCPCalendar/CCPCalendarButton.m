//
//  CCPCalendarButton.m
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "CCPCalendarButton.h"

@interface CCPCalendarButton()
{
    CGFloat fontSize;
    CAShapeLayer *sl;
    CAShapeLayer *sMask;
    CAShapeLayer *eMask;
    CAShapeLayer *otherMask;
    CALayer *orginMask;
}
@end

@implementation CCPCalendarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        fontSize = 14.0 * scale_w;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addTarget:self action:@selector(action:event:) forControlEvents:UIControlEventAllTouchEvents];
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        orginMask = self.layer.mask;
        [self sMask];
        [self eMask];
        [self otherMask];
    }
    return self;
}

- (void)ccpDispaly {
    [self cirPath];

}

- (void)action:(UIButton *)Bbtn event:(UIEvent *)event {
    if (Bbtn.selected == NO) {
        UITouchPhase tp = event.allTouches.anyObject.phase;
        if (tp == UITouchPhaseBegan) {
            sl.fillColor = rgba(255, 255, 255, 0.5).CGColor;
            sl.transform = CATransform3DMakeScale(1.2, 1.2, 1.0);
        }
        else if (tp == UITouchPhaseEnded) {
            sl.transform = CATransform3DIdentity;
            Bbtn.selected = YES;
        }
    }
}


- (void)sMask {
    if (!sMask) {
        CGFloat radius = main_width / 16;
        CGPoint center = CGPointMake(main_width / 14, main_width / 14);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:M_PI_2 endAngle:M_PI * 3 / 2 clockwise:YES];
        [path addLineToPoint:CGPointMake(main_width / 7,main_width / 112)];
        [path addLineToPoint:CGPointMake(main_width / 7, main_width / 8 + main_width / 112)];
        [path closePath];
        sMask = [CAShapeLayer layer];
        sMask.path = path.CGPath;
        sMask.fillColor = [UIColor redColor].CGColor;
        
    }
}

- (void)eMask {
    if (!eMask) {
        CGFloat radius = main_width / 16;
        CGPoint center = CGPointMake(main_width / 14, main_width / 14);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:- M_PI_2 endAngle:M_PI_2 clockwise:YES];
        [path addLineToPoint:CGPointMake(0, main_width / 8 + main_width / 112)];
        [path addLineToPoint:CGPointMake(0, main_width / 112)];
        [path closePath];
        eMask = [CAShapeLayer layer];
        eMask.path = path.CGPath;
        eMask.fillColor = [UIColor redColor].CGColor;
    }
}

- (void)otherMask {
    if (!otherMask) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, main_width / 112)];
        [path addLineToPoint:CGPointMake(main_width / 7, main_width / 112)];
        [path addLineToPoint:CGPointMake(main_width / 7, main_width / 8 + main_width / 112)];
        [path addLineToPoint:CGPointMake(0, main_width / 8 + main_width / 112)];
        [path closePath];
        otherMask = [CAShapeLayer layer];
        otherMask.path = path.CGPath;
        otherMask.fillColor = [UIColor redColor].CGColor;
    }
}

- (void)cirPath {
    CGFloat radius = main_width / 16;
    CGPoint center = CGPointMake(main_width / 14, main_width / 14);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    sl = [CAShapeLayer layer];
    sl.path = path.CGPath;
    sl.lineWidth = 1.0;
    sl.strokeColor = [UIColor clearColor].CGColor;
    sl.fillColor = [UIColor clearColor].CGColor;
    sl.zPosition = -1;
    sl.bounds = self.bounds;
    sl.position = center;
    [sl setAnchorPoint:CGPointMake(0.5, 0.5)];
//    if ([self.date isSameTo:self.manager.createDate]) {
//        sl.strokeColor = [UIColor whiteColor].CGColor;
//    }
    [self.layer addSublayer:sl];
}

@end
