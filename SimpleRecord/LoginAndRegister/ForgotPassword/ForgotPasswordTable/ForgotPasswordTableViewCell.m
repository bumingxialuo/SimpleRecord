//
//  ForgotPasswordTableViewCell.m
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "ForgotPasswordTableViewCell.h"
#import <Masonry.h>
#import "AppSkinColorManger.h"
#import <Chameleon.h>

@interface ForgotPasswordTableViewCell()<UITextFieldDelegate>
{
    ForgotPwdViewTFType _type;
}
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *inputTF;
@property(nonatomic, strong) RDCountDownButton *getCodeBtn;
@end

@implementation ForgotPasswordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.separatorInset =UIEdgeInsetsMake(0, 0, 0, 0);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCellSubView];
    }
    return self;
}

- (void)updateWithPhone:(NSString *)phone {
    _inputTF.text  = phone;
}

- (void)updateWithTitleLabelString:(NSString *)title textFieldPlaceholserString:(NSString *)placeholder showCutDownButton:(BOOL)show passwordStringSecret:(BOOL)secret {
    _titleLabel.text = title;
    _inputTF.placeholder = placeholder;
    if (show) {
        _getCodeBtn.hidden = NO;
        [_inputTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-110);
        }];
    } else {
        _getCodeBtn.hidden = YES;
        [_inputTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    if ([placeholder containsString:@"手机号码"]) {
        _type = ForgotPwdViewTFTypePhone;
        _inputTF.keyboardType = UIKeyboardTypePhonePad;
    } else if ([placeholder containsString:@"短信验证码"]) {
        _type = ForgotPwdViewTFTypeGetVerificationCode;
        _inputTF.keyboardType = UIKeyboardTypeNumberPad;
    } else if ([placeholder containsString:@"包含字母和数字"]) {
        _type = ForgotPwdViewTFTypeNewPassword;
        _inputTF.keyboardType = UIKeyboardTypeASCIICapable;
        _inputTF.secureTextEntry = YES;
    } else if ([placeholder containsString:@"确认登录密码"]) {
        _type = ForgotPwdViewTFTypeNewPasswordEnsure;
        _inputTF.keyboardType = UIKeyboardTypeASCIICapable;
        _inputTF.secureTextEntry = YES;
    }
}

- (void)createCellSubView {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"666"];
    [self.contentView addSubview:_titleLabel];
    
    _inputTF = [[UITextField alloc] init];
    _inputTF.font = [UIFont systemFontOfSize:16];
    _inputTF.textColor = [UIColor colorWithHexString:@"666"];
    [self.contentView addSubview:_inputTF];
    _inputTF.delegate = self;
    [_inputTF addTarget:self action:@selector(textFeildValueChanged:) forControlEvents:UIControlEventEditingChanged];
    _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _getCodeBtn = [RDCountDownButton buttonWithType:UIButtonTypeCustom];
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_getCodeBtn setTitleColor:[AppSkinColorManger sharedInstance].themeColor forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self action:@selector(getForgetCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_getCodeBtn];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    [_getCodeBtn addSubview:line];
    __weak typeof(self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(75);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).offset(0);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(weakSelf.titleLabel);
    }];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(0);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.getCodeBtn.mas_left);
        make.centerY.mas_equalTo(weakSelf.getCodeBtn);
        make.size.mas_equalTo(CGSizeMake(1, 27));
    }];
}

- (void)textFeildValueChanged:(UITextField *)sender {
    if (_type == ForgotPwdViewTFTypePhone) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    } else if (_type == ForgotPwdViewTFTypeGetVerificationCode) {
        if (sender.text.length > 4) {
            sender.text = [sender.text substringToIndex:4];
        }
    } else if (_type == ForgotPwdViewTFTypeNewPassword) {
        if (sender.text.length > 16) {
            sender.text = [sender.text substringToIndex:16];
        }
    } else if (_type == ForgotPwdViewTFTypeNewPasswordEnsure) {
        if (sender.text.length > 16) {
            sender.text = [sender.text substringToIndex:16];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(getTextFieldContent:forgotPwdType:)]) {
        [_cellDelegate getTextFieldContent:textField.text forgotPwdType:_type];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)getForgetCode:(RDCountDownButton *)btn
{
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(forgetViewSendValid:)]) {
        [_cellDelegate forgetViewSendValid:btn];
    }
}

@end
