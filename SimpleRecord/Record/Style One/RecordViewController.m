//
//  RecordViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordViewController.h"
#import "AppSkinColorManger.h"
#import "RecordTableView.h"
#import <Masonry/Masonry.h>

@interface RecordViewController ()<RecordTableViewDelegate>
@property(nonatomic,strong) RecordTableView *tableView;
@end

@implementation RecordViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = @"记录";
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[RecordTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom delegate

#pragma mark - event response

#pragma mark - getters and setters

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
