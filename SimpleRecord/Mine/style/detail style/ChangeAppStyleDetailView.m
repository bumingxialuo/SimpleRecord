//
//  ChangeAppStyleDetailView.m
//  SimpleRecord
//
//  Created by xia on 2018/4/8.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChangeAppStyleDetailView.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "UIImage+color.h"

#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ChangeAppStyleDetailView()
{
    SRColorStyle _style;
    UIColor *_currentColor;
}
@property(nonatomic, strong) UIImageView *prospectsPicture;
@property(nonatomic, strong) UISlider *redSlider;
@property(nonatomic, strong) UISlider *greenSlider;
@property(nonatomic, strong) UISlider *blueSlider;
@property(nonatomic, strong) UILabel *redValue;
@property(nonatomic, strong) UILabel *greenValue;
@property(nonatomic, strong) UILabel *blueValue;
@end

@implementation ChangeAppStyleDetailView

- (instancetype)initViewWithType:(SRColorStyle)type {
    self = [super init];
    _style = type;
    if (self) {
        [self createImageView];
        [self createSliderView];
        [self createDisplayLabelView];
    }
    return self;
}

- (void)createImageView {
    _prospectsPicture = [[UIImageView alloc] init];
    if (_style == SRColorStyleTheme) {
        _currentColor = [AppSkinColorManger sharedInstance].themeColor;
    }
    if (_style == SRColorStyleSecond) {
        _currentColor = [AppSkinColorManger sharedInstance].secondColor;
    }
    if (_style == SRColorStyleThird) {
        _currentColor = [AppSkinColorManger sharedInstance].thirdColor;
    }
    if (_style == SRColorStyleBackground) {
        _currentColor = [AppSkinColorManger sharedInstance].backgroundColor;
    }
    if (_style == SRColorStyleAnimation) {
        _currentColor = [AppSkinColorManger sharedInstance].animationOneColor;
    }
    _prospectsPicture.image = [UIImage createImageWithColor:_currentColor];
    
    [self addSubview:_prospectsPicture];
    [_prospectsPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(40);
        make.left.mas_equalTo(self).offset(44);
        make.right.mas_equalTo(self).offset(-44);
        make.height.mas_equalTo(60);
    }];
}

- (void)createSliderView {
    CGFloat components[3];
    [self getRGBComponents:components forColor:_currentColor];
    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    _redSlider = [[UISlider alloc] init];
    _redSlider.tag = 1001;
    _redSlider.minimumValue = 0;
    _redSlider.maximumValue = 255;
    _redSlider.value = components[0] * 255;
    [_redSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_redSlider addTarget:self action:@selector(sliderValueDidendChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_redSlider];
    [_redSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_prospectsPicture);
        make.right.mas_equalTo(_prospectsPicture.mas_right).offset(-60);
        make.top.mas_equalTo(_prospectsPicture.mas_bottom).offset(50);
        make.height.mas_equalTo(30);
    }];
    
    _greenSlider = [[UISlider alloc] init];
    _greenSlider.tag = 1002;
    _greenSlider.minimumValue = 0;
    _greenSlider.maximumValue = 255;
    _greenSlider.value = components[1] * 255;
    [_greenSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_greenSlider addTarget:self action:@selector(sliderValueDidendChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_greenSlider];
    [_greenSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(_redSlider);
        make.top.mas_equalTo(_redSlider.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
    }];
    
    _blueSlider = [[UISlider alloc] init];
    _blueSlider.tag = 1003;
    _blueSlider.minimumValue = 0;
    _blueSlider.maximumValue = 255;
    _blueSlider.value = components[2] * 255;
    [_blueSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_blueSlider addTarget:self action:@selector(sliderValueDidendChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_blueSlider];
    [_blueSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(_redSlider);
        make.top.mas_equalTo(_greenSlider.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
    }];
}

- (void)createDisplayLabelView {
    _redValue = [[UILabel alloc] init];
    _redValue.text = [NSString stringWithFormat:@"%.0f",_redSlider.value];
    _redValue.textAlignment = NSTextAlignmentRight;
    [self addSubview:_redValue];
    [_redValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_prospectsPicture.mas_right);
        make.centerY.mas_equalTo(_redSlider);
        make.width.mas_equalTo(60);
    }];
    _greenValue = [[UILabel alloc] init];
    _greenValue.text = [NSString stringWithFormat:@"%.0f",_greenSlider.value];
    _greenValue.textAlignment = NSTextAlignmentRight;
    [self addSubview:_greenValue];
    [_greenValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_prospectsPicture.mas_right);
        make.centerY.mas_equalTo(_greenSlider);
        make.width.mas_equalTo(60);
    }];
    _blueValue = [[UILabel alloc] init];
    _blueValue.text = [NSString stringWithFormat:@"%.0f",_blueSlider.value];
    _blueValue.textAlignment = NSTextAlignmentRight;
    [self addSubview:_blueValue];
    [_blueValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_prospectsPicture.mas_right);
        make.centerY.mas_equalTo(_blueSlider);
        make.width.mas_equalTo(60);
    }];
}


- (void)sliderValueChanged:(UISlider *)slider
{
    //    NSLog(@"slider value%f",slider.value);
    NSString *value = [NSString stringWithFormat:@"%0.0f",slider.value];
    if (slider.tag == 1001)
    {
        _redValue.text = value;
    }
    else if (slider.tag == 1002) {
        
        _greenValue.text = value;
    }
    else if (slider.tag == 1003)
    {
        _blueValue.text = value;
    }
    _prospectsPicture.image = [UIImage createImageWithColor:ColorWithAlpha([_redValue.text intValue], [_greenValue.text integerValue], [_blueValue.text integerValue], 1.0) ];
    
}

- (void)sliderValueDidendChanged:(UISlider *)slider {
    if (_viewDelegate && [_viewDelegate respondsToSelector:@selector(sliderViewEndTapWithAllColor:)]) {
        [_viewDelegate sliderViewEndTapWithAllColor:@[ColorWithAlpha([_redValue.text intValue], [_greenValue.text integerValue], [_blueValue.text integerValue], 1.0)]];
    }
}

- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

@end
