//
//  LoginTableViewFillInfoCell.m
//  ZhongNuo
//
//  Created by xia on 2018/4/9.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "LoginTableViewFillInfoCell.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import <Chameleon.h>
#import "CaptchaView.h"

@interface LoginTableViewFillInfoCell()<UITextFieldDelegate>
{
    RightViewType _type;
}
@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UITextField *titleTextField;
@property(nonatomic, strong) UIButton *rightButton;
@property(nonatomic, strong) CaptchaView *captchView;
@property(nonatomic, strong) UIView *line;
@end

@implementation LoginTableViewFillInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCellSubView];
    }
    return self;
}
- (void)updateWithIconImageString:(NSString *)icon titlePlaceHolderString:(NSString *)placeHolder rightButtonType:(RightViewType)type {
    _type = type;
    _icon.image = [UIImage imageNamed:icon];
    _titleTextField.placeholder = placeHolder;
    if ([placeHolder containsString:@"手机号"]) {
        _titleTextField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        _titleTextField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    if (type == RightViewTypePasswordVisible) {
        //可见不可见
        [self captchViewIsHidden:YES RightButtonHidden:NO];
        
    } else if (type == RightViewTypeGraphicVerification) {
        //图形验证码
        [self captchViewIsHidden:NO RightButtonHidden:YES];
        
    } else {
        [self captchViewIsHidden:YES RightButtonHidden:YES];
    }
}

- (void)updateCaptchViewImage:(NSData *)imageData {
//    [CaptchaView ];
}
- (void)captchViewIsHidden:(BOOL)captchHidden RightButtonHidden:(BOOL)rightBtnHidden {
    if (captchHidden) {
        [_captchView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    } else {
        [_captchView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(65);
        }];
    }
    if (rightBtnHidden) {
        [_rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    } else {
        [_rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(30);
        }];
    }
    if (captchHidden && rightBtnHidden) {
        [_titleTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    if (!captchHidden && rightBtnHidden) {
        [_titleTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.captchView.mas_left).offset(-12);
        }];
    }
    if (!rightBtnHidden && captchHidden) {
        [_titleTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(12);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.rightButton.mas_left).offset(-12);
        }];
    }
    
}

- (void)selectedCellChangeLineColor:(BOOL)isSelected {
    if (isSelected) {
        _line.backgroundColor = [AppSkinColorManger sharedInstance].themeColor;
    } else {
        _line.backgroundColor = [UIColor colorWithHexString:@"eee"];
    }
}

- (void)createCellSubView {
    _icon = [[UIImageView alloc] init];
    [self.contentView addSubview:_icon];
    _titleTextField = [[UITextField alloc] init];
    _titleTextField.font = [UIFont systemFontOfSize:16];
    _titleTextField.textColor = [UIColor colorWithHexString:@"666"];
    [self.contentView addSubview:_titleTextField];
    _titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_titleTextField addTarget:self action:@selector(textFeildValueChaged:) forControlEvents:UIControlEventEditingChanged];
    _titleTextField.delegate = self;
    _rightButton = [[UIButton alloc] init];
    [self.contentView addSubview:_rightButton];
    [_rightButton setImage:[UIImage imageNamed:@"icon_kj"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(changeVisiblePassword:) forControlEvents:UIControlEventTouchUpInside];
    _captchView = [[CaptchaView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
    _captchView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_captchView];
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor colorWithHexString:@"eee"];
    [self.contentView addSubview:_line];
    
    float padding = 15.0;
    __weak typeof(self) weakSelf = self;
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(padding);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-padding);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(30);
    }];
    [_captchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-padding);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(65, 25));
    }];
    [_titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(12);
        make.right.mas_equalTo(weakSelf.rightButton.mas_left).offset(-12);
        make.centerY.mas_equalTo(self.contentView);
    }];

    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(padding);
        make.right.mas_equalTo(self.contentView).offset(-padding);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
}

- (void)changeVisiblePassword:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.titleTextField.secureTextEntry = !sender.selected;
    NSString *imgStr = sender.selected ? @"icon_kj" : @"icon_bkj";
    [sender setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
}

- (void)textFeildValueChaged:(UITextField *)sender {
    if (_type == RightViewTypeNone) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    }
    if (_type == RightViewTypePasswordVisible) {
        if (sender.text.length > 16) {
            sender.text = [sender.text substringToIndex:16];
        }
    }
    if (_type == RightViewTypeGraphicVerification) {
        if (sender.text.length > 4) {
            sender.text = [sender.text substringToIndex:4];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _line.backgroundColor = [AppSkinColorManger sharedInstance].themeColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _line.backgroundColor = [UIColor colorWithHexString:@"eee"];
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(toObtainRitghtWithType:titltString:)]) {
        [_cellDelegate toObtainRitghtWithType:_type titltString:_titleTextField.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
