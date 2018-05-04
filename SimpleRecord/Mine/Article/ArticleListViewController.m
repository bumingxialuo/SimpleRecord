 //
//  ArticleListViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ArticleListViewController.h"
#import "AppSkinColorManger.h"
#import "SRUserArticleProfile.h"
#import "RecordListModel.h"
#import "DiaryListTableView.h"
#import <Masonry.h>

@interface ArticleListViewController ()
@property(nonatomic, strong) DiaryListTableView *tableView;
@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title  = @"文章列表";
    [self createtableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *jsonStr = [[SRUserArticleProfile sharedInstance] loadAllArticle];
    NSError *error = nil;
    RecordListModel *listModel = [[RecordListModel alloc] initWithString:jsonStr error:&error];
    [_tableView updateWithArticelModel:listModel];
}

- (void)createtableView {
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



@end
