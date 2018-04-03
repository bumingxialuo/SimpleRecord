//
//  StyleTypeTableView.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "StyleTypeTableView.h"

#define StyleTypeTableViewCellId @"StyleTypeTableViewCellId"

@interface StyleTypeTableView() <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *titleOneArray;
@property(nonatomic, strong) NSMutableArray *titleTwoArray;
@end

@implementation StyleTypeTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupData];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:StyleTypeTableViewCellId];
    }
    return self;
}

#pragma mark - set data
- (void)setupData {
    _titleOneArray = [[NSMutableArray alloc] initWithCapacity:0];
    _titleTwoArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSDictionary *dic1 = @{@"title":@"主题色",@"fill":@"DFADE4",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic2 = @{@"title":@"第一辅色",@"fill":@"00B2EE",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic3 = @{@"title":@"第二辅色",@"fill":@"9a90dc",@"desc":@"9a90dc",@"click":@(YES)};
    NSDictionary *dic4 = @{@"title":@"背景色",@"fill":@"f5f5f5",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic5 = @{@"title":@"动画色",@"fill":@"9a7e68",@"desc":@"",@"click":@(YES)};
    
    [_titleOneArray addObject:dic1];
    [_titleOneArray addObject:dic2];
    [_titleOneArray addObject:dic3];
    [_titleOneArray addObject:dic4];
    [_titleOneArray addObject:dic5];
    
    NSDictionary *dic11 = @{@"title":@"文章开关",@"fill":@"",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic12 = @{@"title":@"日记方案",@"fill":@"",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic13 = @{@"title":@"文章方案",@"fill":@"",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic14 = @{@"title":@"我的方案",@"fill":@"",@"desc":@"",@"click":@(YES)};
    
    [_titleTwoArray addObject:dic11];
    [_titleTwoArray addObject:dic12];
    [_titleTwoArray addObject:dic13];
    [_titleTwoArray addObject:dic14];
}

#pragma mark - UITableViewDelegate And UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _titleOneArray.count;
    } else if (section == 1) {
        return _titleTwoArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StyleTypeTableViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
