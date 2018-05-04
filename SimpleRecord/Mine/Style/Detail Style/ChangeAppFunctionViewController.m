//
//  ChangeAppFunctionViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/5/2.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChangeAppFunctionViewController.h"
#import "SRRouterManager.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "Macro.h"

#define ChangeAppFunctionTableViewCellId @"ChangeAppFunctionTableViewCellId"

@interface ChangeAppFunctionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_title;
    NSMutableArray *_cellTitleArray;
}
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ChangeAppFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = _title;
    [self setupData];
    [self createTableView];
}

- (void)setParams:(NSDictionary *)params {
    _title = params[@"title"];
}

- (void)setupData {
    if ([_title containsString:@"开关"]) {
        _cellTitleArray = [@[@"开启",@"关闭"] mutableCopy];
    } else {
        
    }
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ChangeAppFunctionTableViewCellId];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChangeAppFunctionTableViewCellId forIndexPath:indexPath];
    cell.textLabel.text = _cellTitleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTitleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 10)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 0.01)];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
