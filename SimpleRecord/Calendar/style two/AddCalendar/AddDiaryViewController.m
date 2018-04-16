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
#import "CalendarInfoManager.h"
#import "SRRouterManager.h"

@interface AddDiaryViewController ()<AddCalendarTableViewDelegate>
{
    NSString *_navTitle;
    NSString *_text;
    CalendarOperationStyle _style;
}
@property(nonatomic, strong) AddCalendarTableView *tableView;
@end

@implementation AddDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = _navTitle;
    [self createTableView];
    [self createRightButton];
}

- (void)setParams:(NSDictionary *)params {
    _navTitle = params[@"navTitle"];
    NSString *styleStr = params[@"style"];
    if ([styleStr isEqualToString:@"10"]) {
        _style = CalendarOperationStyleAdd;
    } else if ([styleStr isEqualToString:@"20"]) {
        _style = CalendarOperationStyleCat;
    } else if ([styleStr isEqualToString:@"30"]) {
        _style = CalendarOperationStyleUpdate;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CalendarDataModel *model = [[CalendarInfoManager sharedManager] findByDate:[NSDate date]];
    [_tableView updateWithDataModel:model];
    [_tableView reloadData];
}

- (void)createRightButton {
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.textColor = [UIColor whiteColor];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)createTableView {
    _tableView = [[AddCalendarTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.tableViewDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)saveButtonClick {
    [self.view endEditing:YES];
    [self saveInfoToInstance];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveInfoToInstance {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    CalendarDataModel *model = [CalendarDataModel new];
    model.date = dateStr;
    model.content = _text;
    [[CalendarInfoManager sharedManager] insertOrUpdate:model];
}

- (void)getCalendarContextWithContext:(NSString *)str {
    _text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
