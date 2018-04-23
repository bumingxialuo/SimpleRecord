//
//  AddOneArticleViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/23.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "AddOneArticleViewController.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "SRUserArticleProfile.h"
#import "SRRouterManager.h"
#import "Macro.h"
#import "AddOneArticleTableView.h"
#import "SRAppUserProfile.h"
#import "XJDAlertView.h"
#import "SRRouterUrl.h"
#import "NOTICE.h"
#import <SVProgressHUD.h>
#import "NSString+EnciphermentProtection.h"
#import "RecordDataModel.h"

@interface AddOneArticleViewController ()<AddOneArticleTableViewDelegate>
{
    NSString *_type;
    NSString *_articleId;
    NSString *_title;
    NSString *_content;
}
@property AddOneArticleTableView *tableView;
@end

@implementation AddOneArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([_type isEqualToString:@"add"]) {
        self.navigationItem.title = @"新建文章";
    } else {
        self.navigationItem.title = @"更新文章";
    }
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    [SRUserArticleProfile sharedInstance].articleId = _articleId;
    [self createRightSaveItem];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![SRAppUserProfile sharedInstance].isLogon) {
        return;
    }
    NSString *jsonStr = [[SRUserArticleProfile sharedInstance] findOneArticle];
    NSError *error = nil;
    RecordDataModel *model = [[RecordDataModel alloc] initWithString:jsonStr error:&error];
    [_tableView updateWithModel:model];
    [_tableView reloadData];
}

- (void)setParams:(NSDictionary *)params {
    _type = params[@"type"];
    _articleId = params[@"id"];
}

- (void)createRightSaveItem {
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createTableView {
    _tableView = [[AddOneArticleTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)saveButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![SRAppUserProfile sharedInstance].isLogon) {
        XJDAlertView *alert = [[XJDAlertView alloc] initWithTitle:@"" contentText:@"你还没有登录哦" leftButtonTitle:@"取消" rightButtonTitle:@"去登录"];
        alert.rightBlock = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_UserLogIn object:nil];
        };
        [alert show];
        return;
    }
    if (_title.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"文章标题不能为空"];
        return;
    }
    if (_content.length <= 0 || [_content isEqualToString:@"在此键入你的文章内容"]) {
        [SVProgressHUD showErrorWithStatus:@"文章内容不能为空"];
        return;
    }
    if ([_type isEqualToString:@"add"]) {
        [SRUserArticleProfile sharedInstance].addTime = [NSString dateConvertToString:[NSDate date]];
    }
    [SRUserArticleProfile sharedInstance].lastUpdateTime = [NSString dateConvertToString:[NSDate date]];
    [SRUserArticleProfile sharedInstance].content = _content;
    NSString *number = [SRUserArticleProfile sharedInstance].modifyNum ? [SRUserArticleProfile sharedInstance].modifyNum : 0;
    NSInteger modify = [number integerValue] + 1;
    [SRUserArticleProfile sharedInstance].modifyNum = [NSString stringWithFormat:@"%ld",modify];
    [SRUserArticleProfile sharedInstance].title = _title;
    if ([_type isEqualToString:@"add"]) {
        [[SRUserArticleProfile sharedInstance] insertArtcle];
    } else {
        [[SRUserArticleProfile sharedInstance] saveArticle];
    }
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark = AddOneArticleTableViewDelegate
- (void)tableViewDidEndEditingReturnTitle:(NSString *)title content:(NSString *)content {
    _title = title;
    _content = content;
}

@end
