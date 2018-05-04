//
//  ChageAppStyleViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChageAppStyleViewController.h"
#import "AppSkinColorManger.h"
#import "StyleTypeTableView.h"
#import <Masonry.h>
#import "SRRouterManager.h"
#import "XJDAlertView.h"
#import "CustomTabBarConterller.h"

@interface ChageAppStyleViewController ()<StyleTypeTableViewDelegate>
{
   
}
@property(nonatomic, strong) StyleTypeTableView *tableView;
@end

@implementation ChageAppStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"样式设置";
    [self createRightButton];
    [self createSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView updataColor];
    [_tableView reloadData];
}

- (void)createRightButton {
    UIButton *updateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [updateButton setTitle:@"更改" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:updateButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createSubView {
    _tableView = [[StyleTypeTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)updateButtonClick {
    XJDAlertView *alert = [[XJDAlertView alloc] initWithTitle:@"" contentText:@"确认更改吗？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    alert.rightBlock = ^{
         UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[CustomTabBarConterller alloc] init];
    };
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - StyleTypeTableViewDelegate
- (void)didselectStyleTypeTableViewCellWithTitle:(NSString *)title indexSection:(NSInteger)section {
    if (section == 0) {
        UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_ChangeStyle_ColorSlider(title)];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_ChangeStyle_PageStyle(title)];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
