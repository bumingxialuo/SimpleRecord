//
//  RegisterViewController.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/17.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RegisterViewController.h"
#import "SRRouterManager.h"
#import "RegisterTableView.h"
#import <Masonry.h>
#import "AppSkinColorManger.h"
#import <SVProgressHUD.h>
#import "NSString+EnciphermentProtection.h"
#import "SRAppUserProfile.h"
#import "XJDAlertView.h"
#import <SVProgressHUD.h>
#import "NOTICE.h"

@interface RegisterViewController ()<RegisterTableViewDelegate>
{
    NSString *_phone;
}
@property(nonatomic, strong) RegisterTableView *tableView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = @"注册";
    [self createTableView];
    [self updateWithPhone];
}

- (void)setParams:(NSDictionary *)params {
    _phone = params[@"phone"];
    if ([_phone isEqualToString:@"**"]) {
        _phone = @"";
    }
}

- (void)createTableView {
    _tableView = [[RegisterTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)updateWithPhone {
    [_tableView updatePhoneNumber:_phone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark = RegisterTableViewDelegate

- (void)registerButtonIntableViewClick:(UIButton *)sender Param:(NSDictionary *)param {
    NSString *phone = param[@"phone"];
    NSString *password = param[@"loginPwd"];
    NSString *check = param[@"checkPwd"];
    NSString *code = param[@"code"];
    if (![self checkFillInDataWith:phone password:password checkPwd:check code:code]) {
        return;
    }
    [SRAppUserProfile sharedInstance].userName = phone;
    if ([SRAppUserProfile sharedInstance].judgeUserExit) {
        [SRAppUserProfile sharedInstance].userName = @"";
        [SVProgressHUD showErrorWithStatus:@"该手机号已被注册"];
        return;
    }
    [SRAppUserProfile sharedInstance].password = [NSString md5To32bit:password];
    [SRAppUserProfile sharedInstance].userIsLogin = @"10";
    if ([[SRAppUserProfile sharedInstance] userRegister]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"未知错误"];
    }
    
}

- (void)registerTableViewSendValidCodeWithPhone:(NSString *)phone sender:(RDCountDownButton *)sender {
    if (phone.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return ;
    }
    if (phone.length < 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确格式的手机号"];
        return ;
    }
    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
    [self countDownMethodWithButton:sender];
}

- (void)registViewSelectArgreeWithTitle:(NSString *)title urlString:(NSString *)url {
    
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

- (BOOL)checkFillInDataWith:(NSString *)phone password:(NSString *)password checkPwd:(NSString *)check code:(NSString *)code {
    if (phone.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return NO;
    }
    if (password.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return NO;
    }
    if (check.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return NO;
    }
    if (code.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return NO;
    }
    if (phone.length < 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确格式的手机号"];
        return NO;
    }
    if (![NSString judgePassWordLegal:password]) {
        [SVProgressHUD showErrorWithStatus:@"密码格式不正确"];
        return NO;
    }
    if (![check isEqualToString:password]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return NO;
    }
    if (code.length < 4) {
        [SVProgressHUD showErrorWithStatus:@"验证码格式不正确"];
        return NO;
    }
    return YES;
}

@end
