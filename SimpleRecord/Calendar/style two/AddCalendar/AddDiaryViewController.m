//
//  AddDiaryViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/8.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "AddDiaryViewController.h"
#import "AppSkinColorManger.h"
#import "AddCalendarTableView/AddCalendarTableView.h"
#import <Masonry.h>

@interface AddDiaryViewController ()
@property(nonatomic, strong) AddCalendarTableView *tableView;
@end

@implementation AddDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"新建日记";
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[AddCalendarTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
