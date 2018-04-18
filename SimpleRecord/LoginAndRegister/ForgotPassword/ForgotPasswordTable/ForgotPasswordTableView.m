//
//  ForgotPasswordTableView.m
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "ForgotPasswordTableView.h"
#import "ForgotPasswordTableViewCell.h"
#import <Masonry.h>
#import "AppSkinColorManger.h"
#import "Macro.h"

#define ForgotPasswordTableViewCellId @"ForgotPasswordTableViewCellId"

@interface ForgotPasswordTableView()<UITableViewDelegate, UITableViewDataSource, ForgotPasswordTableViewCellDelegate>
{
    NSString *_phone;
    NSString *_code;
    NSString *_loginPwd;
    NSString *_checkPwd;
}
@property(nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation ForgotPasswordTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.separatorColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.delegate = self;
        self.dataSource = self;
        [self setUpdata];
        [self registerTableViewCell];
        [self createFootView];
    }
    return self;
}

- (void)updateWithPhone:(NSString *)phone {
    _phone = phone;
}

- (void)setUpdata {
    _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *dic1 = @{@"title":@"手机号",@"placeHolder":@"请输入手机号码",@"fill":@"",@"code":@(NO),@"password":@(NO)};
    NSDictionary *dic2 = @{@"title":@"验证码",@"placeHolder":@"请输入短信验证码",@"fill":@"",@"code":@(YES),@"password":@(NO)};
    NSDictionary *dic3 = @{@"title":@"新密码",@"placeHolder":@"8-16位字符，包含字母和数字",@"fill":@"",@"code":@(NO),@"password":@(YES)};
    NSDictionary *dic4 = @{@"title":@"确认密码",@"placeHolder":@"请确认登录密码",@"fill":@"",@"code":@(NO),@"password":@(YES)};
    [_titleArray addObject:dic1];
    [_titleArray addObject:dic2];
    [_titleArray addObject:dic3];
    [_titleArray addObject:dic4];
}

- (void)registerTableViewCell {
    [self registerClass:[ForgotPasswordTableViewCell class] forCellReuseIdentifier:ForgotPasswordTableViewCellId];
}

- (void)createFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 80)];
    footView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    UIButton *nextButton = [[UIButton alloc] init];
    [footView addSubview:nextButton];
    [nextButton setBackgroundColor:[AppSkinColorManger sharedInstance].themeColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footView).offset(15);
        make.right.mas_equalTo(footView).offset(-15);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(footView);
    }];
    self.tableFooterView = footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForgotPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForgotPasswordTableViewCellId];
    cell.cellDelegate = self;
    NSDictionary *indexDic = _titleArray[indexPath.row];
    NSNumber *code = indexDic[@"code"];
    NSNumber *password = indexDic[@"password"];
    if (indexPath.row == 0) {
        [cell updateWithPhone:_phone];
    }
    [cell updateWithTitleLabelString:indexDic[@"title"] textFieldPlaceholserString:indexDic[@"placeHolder"] showCutDownButton:[code boolValue] passwordStringSecret:[password boolValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 10)];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 0.01)];
    return view;
}

- (void)nextButtonClick:(UIButton *)sender {
    [self endEditing:YES];
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(nextButtonInTableViewClick:Phone:code:password:passwordEnsure:)]) {
        [_tableViewDelegate nextButtonInTableViewClick:sender Phone:_phone code:_code password:_loginPwd passwordEnsure:_checkPwd];
    }
}

#pragma mark - ForgotPasswordTableViewCellDelegate
- (void)forgetViewSendValid:(RDCountDownButton *)sender {
    [self endEditing:YES];
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(forgetTableViewSendValidCode:sender:)]) {
        [_tableViewDelegate forgetTableViewSendValidCode:_phone sender:sender];
    }
}

- (void)getTextFieldContent:(NSString *)text forgotPwdType:(ForgotPwdViewTFType)type {
    if (type == ForgotPwdViewTFTypePhone) {
        _phone = text;
    } else if (type == ForgotPwdViewTFTypeGetVerificationCode) {
        _code = text;
    } else if (type == ForgotPwdViewTFTypeNewPassword) {
        _loginPwd = text;
    } else if (type == ForgotPwdViewTFTypeNewPasswordEnsure) {
        _checkPwd = text;
    }
}
@end
