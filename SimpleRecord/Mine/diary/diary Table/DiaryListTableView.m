//
//  DiaryListTableView.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/15.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "DiaryListTableView.h"
#import "AppSkinColorManger.h"
#import "DiaryListTableViewCell.h"
#import <Chameleon.h>
#import "Macro.h"
#import "CalendarViewModel.h"
#import "RecordViewModel.h"

#define DiaryListTableViewCellId @"DiaryListTableViewCellId"
#define DiaryListTableViewContentCellId @"DiaryListTableViewContentCellId"

@interface DiaryListTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray<CalendarDataModel *> *_listModel;
    NSArray<RecordDataModel *> *_articelListModel;
}
@property(nonatomic, strong) NSMutableArray<NSMutableArray *> *tableViewDataSouce;
@property(nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation DiaryListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerTableViewCell];
        [self createData];
    }
    return self;
}
- (void)updateWithModel:(CalendarListModel *)model {
    _listModel = model.list;
    [_tableViewDataSouce removeAllObjects];
    
    _titleArray = [self createTitleArry];
    
    for (NSDictionary *yearDic in _titleArray) {
        NSMutableArray *sectionArray = [NSMutableArray new];
        for (CalendarDataModel *model in _listModel) {
            CalendarViewModel *viewModel = [[CalendarViewModel alloc] initWithModel:model];
            if ([viewModel.addYear isEqualToString:yearDic[@"title"]]) {
                [sectionArray addObject:[self createMutableDic:viewModel.addMonthAndDay value:viewModel.title]];
            }
        }
        [_tableViewDataSouce addObject:sectionArray];
    }
    
}

- (void)updateWithArticelModel:(RecordListModel *)model {
    _articelListModel = model.list;
    _titleArray = [self createArticelTitleArry];
    [_tableViewDataSouce removeAllObjects];
    for (NSDictionary *yearDic in _titleArray) {
        NSMutableArray *sectionArray = [NSMutableArray new];
        for (RecordDataModel *model in _articelListModel) {
            RecordViewModel *viewModel = [[RecordViewModel alloc] initWithModel:model];
            if ([viewModel.addYear isEqualToString:yearDic[@"title"]]) {
                [sectionArray addObject:[self createMutableDic:viewModel.createMonth value:viewModel.title]];
            }
        }
        [_tableViewDataSouce addObject:sectionArray];
    }
}

- (NSMutableArray *)createTitleArry{
    NSMutableArray *yearArray = [NSMutableArray new];
    for (CalendarDataModel *model in _listModel) {
        CalendarViewModel *viewModel = [[CalendarViewModel alloc] initWithModel:model];
        [yearArray addObject:viewModel.addYear];
    }
    NSSet *set = [NSSet setWithArray:[yearArray mutableCopy]];
    yearArray = [[set allObjects] mutableCopy];
    NSMutableArray *mutaArr = [NSMutableArray new];
    for (NSString *addYear in yearArray) {
        [mutaArr addObject:[self createMutableDic:addYear status:NO]];
    }
    return mutaArr;
}

- (NSMutableArray *)createArticelTitleArry {
    NSMutableArray *yearArray = [NSMutableArray new];
    for (RecordDataModel *model in _articelListModel) {
        RecordViewModel *viewModel = [[RecordViewModel alloc] initWithModel:model];
        [yearArray addObject:viewModel.addYear];
    }
    NSSet *set = [NSSet setWithArray:[yearArray mutableCopy]];
    yearArray = [[set allObjects] mutableCopy];
    NSMutableArray *mutaArr = [NSMutableArray new];
    for (NSString *addYear in yearArray) {
        [mutaArr addObject:[self createMutableDic:addYear status:NO]];
    }
    return mutaArr;
}

- (void)createData {
    _titleArray = [NSMutableArray new];
    _tableViewDataSouce = [NSMutableArray new];
}

- (NSMutableDictionary *)createMutableDic:(NSString *)title value:(NSString *)value {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:title forKey:@"title"];
    [dic setObject:value forKey:@"value"];
    return dic;
}

- (NSMutableDictionary *)createMutableDic:(NSString *)title status:(BOOL)status {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:title forKey:@"title"];
    [dic setObject:@(status) forKey:@("value")];
    return dic;
}

- (void)registerTableViewCell {
    [self registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:DiaryListTableViewCellId];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSDictionary *titleDict = _titleArray[indexPath.section];
        NSNumber *boolNum = titleDict[@"value"];
        DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiaryListTableViewCellId forIndexPath:indexPath];
        [cell updateWithTitle:titleDict[@"title"] value:_tableViewDataSouce[indexPath.section].count isOpen:[boolNum boolValue]];
        return cell;
    } else {
        NSArray *sectionArr = _tableViewDataSouce[indexPath.section];
        NSDictionary *dic = sectionArr[indexPath.row-1];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiaryListTableViewContentCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DiaryListTableViewContentCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999"];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"999"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }
        cell.textLabel.text = dic[@"title"];
        cell.detailTextLabel.text = dic[@"value"];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 0) {
        NSDictionary *titleDic = _titleArray[indexPath.section];
        NSNumber *boolNum = titleDic[@"value"];
        _titleArray[indexPath.section][@"value"] = [NSNumber numberWithBool:![boolNum boolValue]];
    }
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber *boolNum = _titleArray[section][@"value"];
    return [boolNum boolValue] ? _tableViewDataSouce[section].count+1 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 50;
    }
    return 30;
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

@end
