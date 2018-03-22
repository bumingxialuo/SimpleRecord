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

@interface RecordStyleTwoViewController ()
@property(nonatomic, strong) RecordStyleTwoTableView *tableView;
@end

@implementation RecordStyleTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[RecordStyleTwoTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
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
