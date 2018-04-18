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
        phone = @"*";
    }
    UIViewController *vc = [[HHRouter shared] matchController:SR_LoginAndRegister_Register(phone)];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
