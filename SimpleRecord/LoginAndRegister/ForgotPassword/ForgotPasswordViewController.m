//
//  ForgotPasswordViewController.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/17.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "SRRouterManager.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "Macro.h"
#import "ForgotPasswordTableView.h"
#import <SVProgressHUD.h>
#import "NSString+EnciphermentProtection.h"
#import "SRAppUserProfile.h"

@interface ForgotPasswordViewController ()<ForgotPasswordTableViewDelegate>
{
    NSString *_phone;
    NSString *_type;
}
@property(nonatomic, strong) ForgotPasswordTableView *tableView;
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    if ([_type isEqualToString:@"forgot"]) {
        self.navigationItem.title = @"找回登录密码";
    } else if ([_type isEqualToString:@"modify"]) {
        self.navigationItem.title = @"修改登录密码";
    }
    [self createTableView];
    [self updateWithPhone];
}

- (void)setParams:(NSDictionary *)params {
    _phone = params[@"phone"];
    if ([_phone isEqualToString:@"*"]) {
        _phone = @"";
    }
    _type = params[@"type"];
}

- (void)createTableView {
    _tableView = [[ForgotPasswordTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)updateWithPhone {
    [_tableView updateWithPhone:_phone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ForgotPasswordTableViewDelegate
- (void)nextButtonInTableViewClick:(UIButton *)sender
                             Phone:(NSString *)phone
                              code:(NSString *)code
                          password:(NSString *)password
                    passwordEnsure:(NSString *)check {
    if (code.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (password.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (check.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return;
    }
    if (code.length<4) {
        [SVProgressHUD showErrorWithStatus:@"验证码格式不正确"];
        return;
    }
    if (![NSString judgePassWordLegal:password]) {
        [SVProgressHUD showErrorWithStatus:@"密码格式不正确"];
        return;
    }
    if (![check isEqualToString:password]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return;
    }
    if ([_type isEqualToString:@"forgot"]) {
        if ([code containsString:@"10"]) {
            [SRAppUserProfile sharedInstance].userName = phone;
            [SRAppUserProfile sharedInstance].password = [NSString md5To32bit:password];
            [SRAppUserProfile sharedInstance].userIsLogin = @"10";
            [[SRAppUserProfile sharedInstance] save];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];
        }
    } else {
        [SRAppUserProfile sharedInstance].password = [NSString md5To32bit:password];
        [[SRAppUserProfile sharedInstance] save];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)forgetTableViewSendValidCode:(NSString *)phone sender:(RDCountDownButton *)sender {
    if (phone.length <= 0) {
        [SVProgressHUD showSuccessWithStatus:@"请输入手机号码"];
        return;
    }
    if (phone.length > 11) {
        [SVProgressHUD showSuccessWithStatus:@"请输入正确格式的手机号码"];
        return;
    }
    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
    [self countDownMethodWithButton:sender];
}
-(void)countDownMethodWithButton:(RDCountDownButton *)sender
{
    sender.enabled = NO;
    [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sender startCountDownWithSecond:60];
    
    [sender countDownChanging:^NSString *(RDCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"%zds 重新获取",second];
        return title;
    }];
    [sender  countDownFinished:^NSString *(RDCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        [countDownButton setTitleColor:[AppSkinColorManger sharedInstance].themeColor forState:UIControlStateNormal];
        return @"重新获取";
    }];
}

@end
