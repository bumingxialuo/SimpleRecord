//
//  RegisterTableView.m
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "RegisterTableView.h"
#import "RegisterTableViewCell.h"
#import "AppSkinColorManger.h"
#import <Chameleon.h>
#import <Masonry.h>
#import <YYText.h>
#import "Macro.h"

#define RegisterTableViewCellId @"RegisterTableViewCellId"

@interface RegisterTableView()<UITableViewDelegate, UITableViewDataSource, RegisterTableViewCellDelegate>
{
    NSString *_phone;
    NSString *_code;
    NSString *_password;
    NSString *_passwordEnsure;
}

@property(nonatomic, strong) NSMutableArray *titleArray;

@property(nonatomic, strong) UIView *footView;
@property(nonatomic, strong) UIButton *registerButton;
@property(nonatomic, strong) YYLabel *protocolView;
@end

@implementation RegisterTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.separatorColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.delegate = self;
        self.dataSource = self;
        [self setUpData];
        [self registerTableViewCell];
        [self createFootView];;
    }
    return self;
}

- (void)updatePhoneNumber:(NSString *)phone {
    _phone = phone;
}

//- (void)updateWithDataModel:(RegisterDataModel *)model {
//    NSString *protocolStr = model.registerText;
//    NSMutableAttributedString *attrbutedprotocalBtn = [[NSMutableAttributedString alloc] initWithString:protocolStr];
//    attrbutedprotocalBtn.yy_font = [UIFont boldSystemFontOfSize:12];
//    attrbutedprotocalBtn.yy_lineSpacing = 8;
//    attrbutedprotocalBtn.yy_color = [RdAppSkinColor sharedInstance].secondaryTextColor;
//    CGSize introSize = CGSizeMake(WIDTHOFSCREEN-30, CGFLOAT_MAX);
//    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attrbutedprotocalBtn];
//    _protocolView.textLayout = layout;
//    CGFloat introHeight = layout.textBoundingSize.height;
//    for (ApplyNoticeDataModel *data in model.applyNotice) {
//        NSString *nameStr = data.title;
//        NSString *protocol = data.value;
//        NSRange rang = [protocolStr rangeOfString:nameStr];
//        [attrbutedprotocalBtn yy_setTextHighlightRange:rang color:[RdAppSkinColor sharedInstance].mainColor backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//            [self lookProtocolWithTitle:nameStr value:protocol];
//        }];
//    }
//    _protocolView.attributedText = attrbutedprotocalBtn;
//    _protocolView.textAlignment = NSTextAlignmentLeft;
//    _footView.frame = CGRectMake(0, 0, WIDTHOFSCREEN, 120+introHeight);
//    self.tableFooterView = _footView;
//}

- (void)setUpData {
    _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *dic1 = @{@"icon":@"icon_sj",@"placeHolder":@"请输入手机号码",@"fill":@"",@"code":@(YES),@"password":@(NO)};
    NSDictionary *dic2 = @{@"icon":@"icon_dx",@"placeHolder":@"请输入短信验证码",@"fill":@"",@"code":@(NO),@"password":@(NO)};
    NSDictionary *dic3 = @{@"icon":@"icon_mm",@"placeHolder":@"8-16位字符，包含字母和数字",@"fill":@"",@"code":@(YES),@"password":@(YES)};
    NSDictionary *dic4 = @{@"icon":@"icon_mm",@"placeHolder":@"请确认登录密码",@"fill":@"",@"code":@(YES),@"password":@(YES)};
    [_titleArray addObject:dic1];
    [_titleArray addObject:dic2];
    [_titleArray addObject:dic3];
    [_titleArray addObject:dic4];
}

- (void)registerTableViewCell {
    [self registerClass:[RegisterTableViewCell class] forCellReuseIdentifier:RegisterTableViewCellId];
}

- (void)createFootView {
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 91)];
    _footView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;;
    
    __weak typeof(self) weakSelf = self;
    
    _protocolView = [[YYLabel alloc] init];
    _protocolView.textColor = [UIColor colorWithHexString:@"666"];
    _protocolView.numberOfLines = 0;
    [_footView addSubview:_protocolView];
    
    _registerButton = [[UIButton alloc] init];
    _registerButton.frame = CGRectMake(0, 0, WIDTHOFSCREEN - 30, 44);
    _registerButton.layer.masksToBounds = YES;
    _registerButton.layer.cornerRadius = 5;
    [_registerButton setBackgroundColor:[AppSkinColorManger sharedInstance].themeColor];
    [_registerButton setTitleShadowColor:[AppSkinColorManger sharedInstance].themeColor forState:UIControlStateNormal];
    [_registerButton setTitleShadowColor:[UIColor colorWithHexString:@"999"] forState:UIControlStateDisabled];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_footView addSubview:_registerButton];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.footView).offset(15);
        make.right.mas_equalTo(weakSelf.footView).offset(-15);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(weakSelf.footView).offset(-30);
    }];
    [_protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 104, 15));
    }];
    
    self.tableFooterView = _footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RegisterTableViewCellId];
    cell.cellDelegate = self;
    NSDictionary *dic = _titleArray[indexPath.row];
    NSNumber *code = dic[@"code"];
    NSNumber *isPassword = dic[@"password"];
    if (indexPath.row == 0) {
        [cell updateWithPhone:_phone];
    }
    [cell updateWithIconName:dic[@"icon"] placeHolderString:dic[@"placeHolder"] isHiddenGetCodeBtn:[code boolValue] passWord:[isPassword boolValue]];
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
- (void)lookProtocolWithTitle:(NSString *)title value:(NSString *)value
{
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(registViewSelectArgreeWithTitle:urlString:)]) {
        [_tableViewDelegate registViewSelectArgreeWithTitle:title urlString:value];
    }
}

- (void)registerButtonClick:(UIButton *)sender {
    [self endEditing:YES];
    NSDictionary *param = @{@"phone":_phone ? _phone : @"",
                            @"loginPwd":_password ? _password : @"",
                            @"checkPwd":_passwordEnsure ? _passwordEnsure :@"",
                            @"code":_code ? _code : @"",
                            @"registerClient":@"ios"};
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(registerButtonIntableViewClick:Param:)]) {
        [_tableViewDelegate registerButtonIntableViewClick:sender Param:param];
    }
}
#pragma mark - RegisterTableViewCellDelegate

- (void)registerViewSendValidCode:(RDCountDownButton *)sender {
    [self endEditing:YES];
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(registerTableViewSendValidCodeWithPhone:sender:)]) {
        [_tableViewDelegate registerTableViewSendValidCodeWithPhone:_phone sender:sender];
    }
}

- (void)getTitleTextFeildContent:(NSString *)title registerType:(RegisterViewTFType)type {
    if (type == RegisterViewTFTypePhone) {
        _phone = title;
    } else if (type == RegisterViewTFTypeGetVerificationCode) {
        _code = title;
    } else if (type == RegisterViewTFTypePassword) {
        _password = title;
    } else if (type == RegisterViewTFTypePasswordEnsure) {
        _passwordEnsure = title;
    }
}


@end
