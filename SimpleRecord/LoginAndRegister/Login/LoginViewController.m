//
//  LoginViewController.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/17.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "LoginViewController.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "LoginTableView.h"
#import "SRRouterManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "SRAppUserProfile.h"

@interface LoginViewController ()<LoginTableViewDelegate>
@property(nonatomic, strong) LoginTableView *tableView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = @"找回登录密码";
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)createTableView {
    _tableView = [[LoginTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoginTableViewDelegate
- (void)closeButtonInTableClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)loginButtonClick:(UIButton *)sender Phone:(NSString *)phone password:(NSString *)password picCode:(NSString *)code {
    if (phone.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    } else if (password.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码"];
        return;
    } else if (code.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入图形验证码"];
        return;
    } else if (phone.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确格式的手机号码"];
    }
    //还要拦截一种密码格式不正确
    
    // 这里可以进行网络请求
    //请求注册借口 ，没有后台所以直接注册成功，直接进入个人中心页面
    [SRAppUserProfile sharedInstance].userName = phone;
    [SRAppUserProfile sharedInstance].password = password;
    [SRAppUserProfile sharedInstance].userIsLogin = @"10";
    [[SRAppUserProfile sharedInstance] save];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)forgotPasswordButtonClickInTableView:(NSString *)phone {
    if ([phone isEqualToString:@""]) {
        phone = @"*";
    }
    UIViewController *vc = [[HHRouter shared] matchController:SR_LoginAndRegister_ForgotPassword(phone)];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)registerButtonClickInTableView:(NSString *)phone {
    if ([phone isEqualToString:@""]) {
        phone = @"**";
    }
    UIViewController *vc = [[HHRouter shared] matchController:SR_LoginAndRegister_Register(phone)];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
