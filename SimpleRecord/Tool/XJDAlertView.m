//
//  RepaymentViewController.h
//  Erongdu
//
//  Created by 李帅良 on 2017/2/15.
//  Copyright © 2017年 heycom.eongdu.xianjingdai. All rights reserved.
//

#import "XJDAlertView.h"
#import "Macro.h"
#import "UIImage+color.h"
#import <Chameleon.h>

#define kAlertWidth WIDTHRADIUS*260.5f

@interface XJDAlertView ()
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *sepLine;
@property (nonatomic, copy) NSString *contentStr;


@end

@implementation XJDAlertView

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

-(CGFloat)alertHeight
{
    CGFloat defaultHeight = WIDTHRADIUS * 90.0f + [self contentSize:_contentStr];
    if(self.alertTitleLabel.text.length){
        defaultHeight += 20;
    }
    return defaultHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kButtonHeight 25.0/320*WIDTHOFSCREEN
#define kButtonWidth  230.5/320*WIDTHOFSCREEN

#define kSingleButtonWidth 461.0/2*WIDTHOFSCREEN/320

#define kCoupleButtonWidth 102.f*WIDTHOFSCREEN/320
#define kCoupleButtonOffset 10
#define kButtonBottomOffset 11.5f

//控制弹框 左右按钮颜色
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
         buttonType:(ButtonType)buttonType
{
    self =  [self initWithTitle:title contentText:content leftButtonTitle:leftTitle rightButtonTitle:rigthTitle];
    if (self) {
        NSString* leftColorHex = @"#1E81D2";
        NSString* rightColorHex = @"#1E81D2";
        switch (buttonType) {
            case Normal:
                break;
            case LeftGray:
                leftColorHex = @"#cccccc";
                break;
            case RightGray:
                rightColorHex = @"#cccccc";
                break;
            default:
                break;
        }
        [self.rightBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:rightColorHex]] forState:UIControlStateNormal];
        [self.leftBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:leftColorHex]] forState:UIControlStateNormal];
        
    }
    return self;
}

//完全自适应alertView
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.text = title;
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        self.alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        [self addSubview:self.alertTitleLabel];
        
        _contentStr = content;
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame) + 8, contentLabelWidth, [self contentSize:content])];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.alertContentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.alertContentLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:self.alertContentLabel];
        //不显示标题 直接显示内容 居中
        if (! (title && ![title isEqualToString:@""])) {
            [self.alertTitleLabel removeFromSuperview];
            self.alertContentLabel.frame = CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, kTitleYOffset, contentLabelWidth, kTitleHeight + [self contentSize:content]);
        }
        
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(0, [self alertHeight] - kButtonBottomOffset - kButtonHeight - 0.5, kAlertWidth, 0.5)];
        self.line.backgroundColor = [UIColor colorWithHexString:@"#d7d7d7"];
        [self addSubview:self.line];
        self.sepLine = [[UILabel alloc]initWithFrame:CGRectMake((kAlertWidth-0.5)/2, [self alertHeight] - kButtonBottomOffset - kButtonHeight - 0.5, 0.5, kButtonHeight + kButtonBottomOffset)];
        self.sepLine.backgroundColor = [UIColor colorWithHexString:@"#d7d7d7"];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        if (!leftTitle || leftTitle.length == 0) {
            rightBtnFrame = CGRectMake(0, [self alertHeight]  - kButtonHeight- kButtonBottomOffset *0.5, kAlertWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = rightBtnFrame;
            
        }else if (!rigthTitle || rigthTitle.length == 0) {
            leftBtnFrame = CGRectMake(0, [self alertHeight]  - kButtonHeight- kButtonBottomOffset *0.5, kAlertWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = leftBtnFrame;
            
        }else {
            leftBtnFrame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, [self alertHeight]  - kButtonHeight- kButtonBottomOffset*0.5, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + kButtonBottomOffset, [self alertHeight]  - kButtonHeight- kButtonBottomOffset*0.5, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
            
            [self addSubview:self.sepLine];
            
        }
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftBtn setTitleColor:[UIColor colorWithHexString:@"#1E81D2"] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"#1E81D2"] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertContentLabel.text = content;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    
    return self;
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - [self alertHeight] - 30, kAlertWidth, [self alertHeight]);
    [self exChangeOut:self dur:0.4f];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperviews];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperviews
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, [self alertHeight]);
    
    [UIView animateWithDuration:0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        if (_leftLeave) {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished) {
        //注释原因：DXAlertView弹框切后台会在这crash
        [self removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - [self alertHeight]) * 0.5, kAlertWidth, [self alertHeight]);
    
    [UIView animateWithDuration:0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}
-(CGFloat)contentSize:(NSString *)content{
    return [content boundingRectWithSize:CGSizeMake(kAlertWidth-16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
}
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.08, 1.08, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

@end


