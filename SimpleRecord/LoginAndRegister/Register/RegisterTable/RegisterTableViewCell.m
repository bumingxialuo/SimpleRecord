//
//  RegisterTableViewCell.m
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "RegisterTableViewCell.h"
#import "RDCountDownButton.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "Macro.h"
#import <Chameleon.h>

@interface RegisterTableViewCell()<UITextFieldDelegate>
{
    RegisterViewTFType _type;
}
@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UITextField *titleText;
@property(nonatomic, strong) RDCountDownButton *getCodeBtn;
@end

@implementation RegisterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self createCellSubView];
    }
    return self;
}

- (void)updateWithPhone:(NSString *)phone {
    _titleText.text = phone;
}

- (void)updateWithIconName:(NSString *)icon placeHolderString:(NSString *)placeholder isHiddenGetCodeBtn:(BOOL)isHidden passWord:(BOOL)isPassWord {
    _icon.image = [UIImage imageNamed:icon];
    _titleText.placeholder = placeholder;
    _getCodeBtn.hidden = isHidden;
    if (isHidden) {
        [_titleText mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
    } else {
        [_titleText mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-115);
        }];
    }
    if (isPassWord) {
        _titleText.secureTextEntry = YES;
    } else {
        _titleText.secureTextEntry = NO;
    }
    if ([placeholder containsString:@"手机号码"]) {
        _titleText.keyboardType = UIKeyboardTypeNumberPad;
        _type = RegisterViewTFTypePhone;
    } else if ([placeholder containsString:@"短信验证码"]) {
        _titleText.keyboardType = UIKeyboardTypeNumberPad;
        _type = RegisterViewTFTypeGetVerificationCode;
    } else if ([placeholder containsString:@"包含字母和数字"]) {
        _titleText.keyboardType = UIKeyboardTypeASCIICapable;
        _titleText.secureTextEntry = YES;
        _type = RegisterViewTFTypePassword;
    } else if ([placeholder containsString:@"确认登录密码"]) {
        _titleText.keyboardType = UIKeyboardTypeASCIICapable;
        _titleText.secureTextEntry = YES;
        _type = RegisterViewTFTypePasswordEnsure;
    }
}

- (void)createCellSubView {
    _icon = [[UIImageView alloc] init];
    [self.contentView addSubview:_icon];
    _titleText = [[UITextField alloc] init];
    _titleText.font = [UIFont systemFontOfSize:16];
    _titleText.textColor = [UIColor colorWithHexString:@"666"];
    [self.contentView addSubview:_titleText];
    _titleText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_titleText addTarget:self action:@selector(textFeildValueChanged:) forControlEvents:UIControlEventEditingChanged];
    _titleText.delegate = self;
    _getCodeBtn = [RDCountDownButton buttonWithType:UIButtonTypeCustom];
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_getCodeBtn setTitleColor:[AppSkinColorManger sharedInstance].themeColor forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self action:@selector(getRegisterCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_getCodeBtn];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    [_getCodeBtn addSubview:line];
    
    float padding = 17;
    __weak typeof(self) weakSelf = self;
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(padding);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    [_titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-15);
    }];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 28));
        make.right.mas_equalTo(weakSelf.getCodeBtn.mas_left);
        make.centerY.mas_equalTo(weakSelf.getCodeBtn);
    }];
}
-(void)getRegisterCode:(UIButton *)btn
{
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(registerViewSendValidCode:)]) {
        [_cellDelegate registerViewSendValidCode:_getCodeBtn];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFeildValueChanged:(UITextField *)sender {
    if (_type == RegisterViewTFTypePhone) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    }
    if (_type == RegisterViewTFTypeGetVerificationCode) {
        if (sender.text.length > 4) {
            sender.text = [sender.text substringToIndex:4];
        }
    }
    if (_type == RegisterViewTFTypePassword) {
        if (sender.text.length > 16) {
            sender.text = [sender.text substringToIndex:16];
        }
    }
    if (_type == RegisterViewTFTypePasswordEnsure) {
        if (sender.text.length > 16) {
            sender.text = [sender.text substringToIndex:16];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(getTitleTextFeildContent:registerType:)]) {
        [_cellDelegate getTitleTextFeildContent:textField.text registerType:_type];
    }
}

@end
