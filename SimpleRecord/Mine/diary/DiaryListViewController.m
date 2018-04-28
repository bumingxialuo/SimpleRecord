//
//  DiaryListViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "DiaryListViewController.h"
#import "AppSkinColorManger.h"
#import "DiaryListTableView.h"
#import <Masonry.h>
#import "SRUserDiaryProfile.h"
#import "CalendarListModel.h"

@interface DiaryListViewController ()
@property(nonatomic,strong) DiaryListTableView *tableView;
@end

@implementation DiaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"日记列表";
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *jsonStr = [[SRUserDiaryProfile sharedInstance] findAllDiaryStr];
    NSError *error = nil;
    CalendarListModel *listModel = [[CalendarListModel alloc] initWithString:jsonStr error:&error];
    [_tableView updateWithModel:listModel];
    [_tableView reloadData];
}

- (void)createTableView {
    _tableView = [[DiaryListTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
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
