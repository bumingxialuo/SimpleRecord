//
//  AccountManagerViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "AccountManagerViewController.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "UIImage+color.h"
#import "SRAppUserProfile.h"
#import "Macro.h"
#import <Chameleon.h>
#import "NOTICE.h"
#import "SRRouterManager.h"

#define AccountManagerTableViewCellId @"AccountManagerTableViewCellId"

@interface AccountManagerViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_tableViewData;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *logoutButton;
@end

@implementation AccountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"帐号管理";
    [self setUpData];
    [self createTableView];
    [self createFootView];
}

- (void)setUpData {
    _tableViewData = @[@{@"title":@"用户",@"value":[SRAppUserProfile sharedInstance].hideUserName ? [SRAppUserProfile sharedInstance].hideUserName : @"182****2521"},
                       @{@"title":@"修改登录密码",@"value":@""}];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    _tableView.separatorColor = [AppSkinColorManger sharedInstance].backgroundColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
}

- (void)createFootView {
    _logoutButton = [[UIButton alloc] init];
    [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(logoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _logoutButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_logoutButton setTitleColor:[AppSkinColorManger sharedInstance].themeColor forState:UIControlStateNormal];
    [_logoutButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.view addSubview:_logoutButton];
    [_logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutButtonClick:(UIButton *)sender {
    //退出登录
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_UserLogOut object:nil];
}

#pragma mark - UITableViewDelegate And UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountManagerTableViewCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AccountManagerTableViewCellId];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"666"];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"999"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _tableViewData[indexPath.row][@"title"];
    cell.detailTextLabel.text = _tableViewData[indexPath.row][@"value"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        UIViewController *vc = [[HHRouter shared] matchController:SR_LoginAndRegister_ForgotPassword(@"modify",[SRAppUserProfile sharedInstance].userName)];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewData.count;
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
@end
