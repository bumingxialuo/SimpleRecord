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

#define DiaryListTableViewCellId @"DiaryListTableViewCellId"
#define DiaryListTableViewContentCellId @"DiaryListTableViewContentCellId"

@interface DiaryListTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray<CalendarDataModel *> *_listModel;
    BOOL _sectionOneOpen;
    BOOL _sectionTwoOpen;
}
@property(nonatomic, strong) NSMutableArray<NSMutableArray *>*tableViewDataSouce;
@property(nonatomic, strong) NSArray *titleArray;
@end

@implementation DiaryListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.delegate = self;
        self.dataSource = self;
        [self setUpData];
        [self registerTableViewCell];
    }
    return self;
}
- (void)updateWithModel:(NSArray<CalendarDataModel *> *)model {
    _listModel = model;
}
- (void)setUpData {
    _tableViewDataSouce = [[NSMutableArray alloc] initWithCapacity:0];
    [_tableViewDataSouce addObject:[self createOneSectionData]];
    [_tableViewDataSouce addObject:[self createTwoSectionData]];
    _titleArray = @[@"2017",@"2018"];
}

- (NSMutableArray *)createOneSectionData {
    NSMutableArray *sectionArray = [[NSMutableArray alloc] initWithCapacity:0];
    [sectionArray addObject:[self createMutableDic:@"06-15" value:@"特别的事情"]];
    [sectionArray addObject:[self createMutableDic:@"07-01" value:@"中软实习"]];
    [sectionArray addObject:[self createMutableDic:@"08-01" value:@"融都实习"]];
    return sectionArray;
}
- (NSMutableArray *)createTwoSectionData {
    NSMutableArray *sectionArray = [[NSMutableArray alloc] initWithCapacity:0];
    [sectionArray addObject:[self createMutableDic:@"01-01" value:@"新的一年"]];
    [sectionArray addObject:[self createMutableDic:@"04-05" value:@"清明"]];
    return sectionArray;
}

- (NSMutableDictionary *)createMutableDic:(NSString *)title value:(NSString *)value {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:title forKey:@"title"];
    [dic setObject:value forKey:@"value"];
    return dic;
}

- (void)registerTableViewCell {
    [self registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:DiaryListTableViewCellId];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _sectionOneOpen ? _tableViewDataSouce[section].count : 1;
    } else {
        return _sectionTwoOpen ? _tableViewDataSouce[section].count : 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiaryListTableViewCellId forIndexPath:indexPath];
        if (!_listModel) {
            NSString *value = [NSString stringWithFormat:@"共%lu篇",(unsigned long)_tableViewDataSouce[indexPath.section].count];
            [cell updateWithTitle:_titleArray[indexPath.section] value:value isOpen:indexPath.section == 0 ? _sectionOneOpen : _sectionTwoOpen];
        }
        return cell;
    } else {
        NSMutableDictionary *dic = _tableViewDataSouce[indexPath.section][indexPath.row-1];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiaryListTableViewContentCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DiaryListTableViewContentCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999"];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"999"];
            cell.textLabel.text = dic[@"title"];
            cell.detailTextLabel.text = dic[@"value"];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 50;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 0) {
        if (indexPath.section == 0) {
            _sectionOneOpen = !_sectionOneOpen;
        } else {
            _sectionTwoOpen = !_sectionTwoOpen;
        }
    }
    [self reloadData];
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
