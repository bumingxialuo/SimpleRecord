//
//  LoginTableView.m
//  ZhongNuo
//
//  Created by xia on 2018/4/9.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "LoginTableView.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "Macro.h"
#import "LoginTableViewFillInfoCell.h"
#import <Chameleon.h>

#define LoginTableViewFillInfoCellId @"LoginTableViewFillInfoCellId"

@interface LoginTableView()<UITableViewDelegate, UITableViewDataSource, LoginTableViewFillInfoCellDelegate>
{
    NSString *_phoneNumber;
    NSString *_password;
    NSString *_picCode;
    NSData *_captchaData;
}

@property(nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIButton *forgotPasswordButton;
@property(nonatomic, strong) UIButton *registerButton;
@end

@implementation LoginTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setUpData];
        [self registerTableViewCell];
        [self createHeadView];
        [self createFootView];
    }
    return self;
}
- (void)updateWithCaptchaData:(NSData *)imageData {
    _captchaData = imageData;
    [self reloadData];
}
- (void)setUpData {
    _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *dic1 = @{@"icon":@"icon_sj",@"placeHolder":@"请输入手机号码",@"fill":@"",@"type":@(RightViewTypeNone),@"selected":@(YES)};
    NSDictionary *dic2 = @{@"icon":@"icon_mm",@"placeHolder":@"请输入登录密码",@"fill":@"",@"type":@(RightViewTypePasswordVisible),@"selected":@(NO)};
    NSDictionary *dic3 = @{@"icon":@"icon_login_tx",@"placeHolder":@"请输入图形验证码",@"fill":@"",@"type":@(RightViewTypeGraphicVerification),@"selected":@(NO)};
    [_titleArray addObject:dic1];
    [_titleArray addObject:dic2];
    [_titleArray addObject:dic3];
    
    
}
- (void)registerTableViewCell {
    [self registerClass:[LoginTableViewFillInfoCell class] forCellReuseIdentifier:LoginTableViewFillInfoCellId];
}

- (void)createHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 227+10)];
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:iconImage];
    [headView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(5);
        make.top.mas_equalTo(headView).offset(15);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView).offset(81);
        make.centerX.mas_equalTo(headView);
        make.size.mas_equalTo(CGSizeMake(105, 84));
    }];
    self.tableHeaderView = headView;
}

- (void)createFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 115)];
    _loginButton = [[UIButton alloc] init];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[AppSkinColorManger sharedInstance].themeColor];
    _loginButton.frame = CGRectMake(0, 0, WIDTHOFSCREEN - 30, 44);
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    [footView addSubview:_loginButton];
    
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _forgotPasswordButton = [[UIButton alloc] init];
    [_forgotPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_forgotPasswordButton setBackgroundColor:[UIColor colorWithHexString:@"999"]];
    [footView addSubview:_forgotPasswordButton];
    [_forgotPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [[UIButton alloc] init];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerButton setBackgroundColor:[AppSkinColorManger sharedInstance].themeColor];
    [footView addSubview:_registerButton];
    [_registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footView).offset(15);
        make.right.mas_equalTo(footView).offset(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(footView).offset(25);
    }];
    [_forgotPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footView).offset(15);
        make.top.mas_equalTo(_loginButton.mas_bottom).offset(10);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(footView).offset(-15);
        make.top.mas_equalTo(_loginButton.mas_bottom).offset(10);
    }];
    self.tableFooterView = footView;
}
#pragma mark - UITableViewDelegate And UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoginTableViewFillInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:LoginTableViewFillInfoCellId];
    cell.cellDelegate = self;
    NSDictionary *indexDic = _titleArray[indexPath.row];
    NSNumber *typeI = indexDic[@"type"];
    RightViewType type = [typeI intValue];
    [cell updateWithIconImageString:indexDic[@"icon"] titlePlaceHolderString:indexDic[@"placeHolder"] rightButtonType:type];
    [cell updateCaptchViewImage:_captchaData];
    return cell;
}


#pragma mark - Handle controlEvent
- (void)closeButtonClick {
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(closeButtonInTableClick)]) {
        [_tableViewDelegate closeButtonInTableClick];
    }
}

- (void)loginButtonClick:(UIButton *)sender {
    [self endEditing:YES];
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(loginButtonClick:Phone:password:picCode:)]) {
        [_tableViewDelegate loginButtonClick:sender Phone:_phoneNumber password:_password picCode:_picCode];
    }
}

- (void)forgotPasswordButtonClick:(UIButton *)sender {
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(forgotPasswordButtonClickInTableView:)]) {
        [_tableViewDelegate forgotPasswordButtonClickInTableView:_phoneNumber ? _phoneNumber : @""];
    }
}

- (void)registerButtonClick:(UIButton *)sender {
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(registerButtonClickInTableView:)]) {
        [_tableViewDelegate registerButtonClickInTableView:_phoneNumber ? _phoneNumber : @""];
    }
}

#pragma mark - LoginTableViewFillInfoCellDelegate

- (void)toObtainRitghtWithType:(RightViewType)type titltString:(NSString *)title {
    if (type == RightViewTypeNone) {
        _phoneNumber = title;
    } else if (type == RightViewTypePasswordVisible) {
        _password = title;
    } else if (type == RightViewTypeGraphicVerification) {
        _picCode = title;
    }
}


@end
