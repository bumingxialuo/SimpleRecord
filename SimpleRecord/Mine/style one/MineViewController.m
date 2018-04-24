//
//  MineViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "MineViewController.h"
#import "AppSkinColorManger.h"
#import "MIneTableView.h"
#import <Masonry.h>
#import "SRRouterManager.h"
#import "NOTICE.h"
#import "SRAppUserProfile.h"

@interface MineViewController ()<MineTableViewDelegate>
@property(nonatomic, strong) MineTableView *tableView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = @"我的";
    [self createTableView];
}


#pragma mark - Add SubViews
- (void)createTableView {
    _tableView = [[MineTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - MineTableViewDelegate

- (void)mineTableViewDidSelectRowIndexRow:(NSInteger)index {
    switch (index) {
        case 0:
            [self turnToDiaryListView];
            break;
        case 1:
            [self turnToArticleListView];
            break;
        case 2:
            [self turnToFunctionConfigView];
            break;
        case 3:
            [self turnToChangeStyleView];
            break;
        case 4:
            [self turnToAccountManagerView];
            break;
        default:
            break;
    }
}

- (void)userDoLoginEvent {
    if (![SRAppUserProfile sharedInstance].isLogon) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_UserLogIn object:nil];
    }
}

- (void)turnToDiaryListView {
    if (![SRAppUserProfile sharedInstance].isLogon) {
        return;
    }
    UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_DiaryList];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)turnToArticleListView {
    if (![SRAppUserProfile sharedInstance].isLogon) {
        return;
    }
    UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_ArticleList];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)turnToFunctionConfigView {
    UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_FunctionConfig];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)turnToChangeStyleView {
    UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_ChangeStyle];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)turnToAccountManagerView {
    if (![SRAppUserProfile sharedInstance].isLogon) {
        return;
    }
    UIViewController *vc = [[HHRouter shared] matchController:SR_Mine_AccountManager];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
