//
//  RecordStyleTwoViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordStyleTwoViewController.h"
#import "RecordStyleTwoTableView.h"
#import <Masonry/Masonry.h>
#import "AppSkinColorManger.h"
#import "SRUserArticleProfile.h"
#import "SRAppUserProfile.h"
#import "RecordDataModel.h"
#import "AppSkinColorManger.h"
#import <Chameleon.h>
#import "SRRouterManager.h"

@interface RecordStyleTwoViewController ()<RecordStyleTwoTableViewDelegate>
@property(nonatomic, strong) RecordStyleTwoTableView *tableView;
@property(nonatomic, strong) UIView *emptyView;
@end

@implementation RecordStyleTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"文章";
    [self createRightEditItem];
    [self createTableView];
    [self createNoneView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![SRAppUserProfile sharedInstance].isLogon) {
        return;
    }
    if (![SRUserArticleProfile sharedInstance].userName) {
        [SRUserArticleProfile sharedInstance].userName = [SRAppUserProfile sharedInstance].userName;
    }
    [self requestDataFromDB];
}

- (void)requestDataFromDB {
    NSString *jsonStr = [[SRUserArticleProfile sharedInstance] loadLatestArticle];
    NSError *error = nil;
    RecordDataModel *model = [[RecordDataModel alloc] initWithString:jsonStr error:&error];
    if (model) {
        [self shoeTableView];
        [_tableView updateWithModel:model];
    } else {
        [self showNoneView];
    }
}

- (void)showNoneView {
    _emptyView.hidden = NO;
    _tableView.hidden = YES;
}

- (void)shoeTableView {
    _emptyView.hidden = YES;
    _tableView.hidden = NO;
}

- (void)createRightEditItem  {
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [editBtn setTitle:@"新增" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createNoneView {
    _emptyView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_emptyView];
    
    UIImageView *icon_none = [[UIImageView alloc] init];
    icon_none.image = [[UIImage imageNamed:@"icon_none"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon_none.tintColor = [AppSkinColorManger sharedInstance].thirdColor;
    [_emptyView addSubview:icon_none];
    UILabel *remarkLabel = [[UILabel alloc] init];
    remarkLabel.text = @"这里什么也没有";
    remarkLabel.textColor = [UIColor colorWithHexString:@"999"];
    remarkLabel.font = [UIFont systemFontOfSize:14];
    [_emptyView addSubview:remarkLabel];
    [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [icon_none mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_emptyView);
        make.top.mas_equalTo(_emptyView).offset(120);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(icon_none.mas_bottom).offset(40);
        make.centerX.mas_equalTo(_emptyView);
    }];
    _emptyView.hidden = YES;
}

- (void)createTableView {
    _tableView = [[RecordStyleTwoTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _tableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editBtnClick:(UIButton *)sender {
    UIViewController *vc = [[HHRouter shared] matchController:SR_Record_AddRecord(@"add",@"")];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - RecordStyleTwoTableViewDelegate
- (void)turnToContinumEditingArticleViewWithId:(NSString *)articleId {
    UIViewController *vc = [[HHRouter shared] matchController:SR_Record_AddRecord(@"modify", articleId)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
