//
//  MIneTableView.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/3/25.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "MineTableView.h"
#import "Macro.h"
#import "AppSkinColorManger.h"
#import "MineTableHeadView.h"
#import "MineTableViewCell.h"

#define MineTableViewCellId @"MineTableViewCellId"

@interface MineTableView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic, strong) MineTableHeadView *headView;
@end

@implementation MineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.delegate = self;
        self.dataSource = self;
        [self setUpdata];
        [self createHeadView];
        [self registerTableViewCell];
    }
    return self;
}

- (void)setUpdata {
    _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *dict1 = @{@"icon":@"\U0000e733",@"title":@"日记列表",@"click":@(YES)};
    [_titleArray addObject:dict1];
    NSDictionary *dict2 = @{@"icon":@"\U0000e654",@"title":@"文章列表",@"click":@(YES)};
    [_titleArray addObject:dict2];
    NSDictionary *dict3 = @{@"icon":@"\U0000e605",@"title":@"功能配置",@"click":@(YES)};
    [_titleArray addObject:dict3];
    NSDictionary *dict4 = @{@"icon":@"\U0000e6f4",@"title":@"样式设置",@"click":@(YES)};
    [_titleArray addObject:dict4];
    NSDictionary *dict5 = @{@"icon":@"\U0000e608",@"title":@"帐号管理",@"click":@(YES)};
    [_titleArray addObject:dict5];
}

- (void)createHeadView {
    _headView = [[MineTableHeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 180)];
    self.tableHeaderView = _headView;
}

- (void)registerTableViewCell {
    [self registerClass:[MineTableViewCell class] forCellReuseIdentifier:MineTableViewCellId];
}

#pragma mark - UItableViewDelegate And UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateWithIconImageName:_titleArray[indexPath.row][@"icon"] TitleString:_titleArray[indexPath.row][@"title"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(mineTableViewDidSelectRowIndexRow:)]) {
        [_tableViewDelegate mineTableViewDidSelectRowIndexRow:indexPath.row];
    }
}

@end
