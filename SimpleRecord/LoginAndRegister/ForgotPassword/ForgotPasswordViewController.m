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

@interface ForgotPasswordViewController ()
{
    NSString *_phone;
}
@property(nonatomic, strong) ForgotPasswordTableView *tableView;
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = @"找回登录密码";
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[ForgotPasswordTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)setParams:(NSDictionary *)params {
    _phone = params[@"phone"];
    if ([_phone isEqualToString:@"*"]) {
        _phone = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
