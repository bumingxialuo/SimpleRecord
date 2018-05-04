//
//  StyleTypeTableView.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "StyleTypeTableView.h"
#import "StyleTypeTableViewCell.h"
#import "Macro.h"
#import <ChameleonFramework/Chameleon.h>
#import <Masonry.h>
#import "AppSkinColorManger.h"
#import "TableDataSource.h"

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
        [self registerClass:[StyleTypeTableViewCell class] forCellReuseIdentifier:StyleTypeTableViewCellId];
        [self setupData];
    }
    return self;
}

#pragma mark - set data
- (void)setupData {
    _titleOneArray = [[TableDataSource alloc] createTableViewSectionOneDataSource];
    _titleTwoArray = [[TableDataSource alloc] createTableViewSectionTwoDataSource];
}

- (void)updataColor {
    if (!_titleOneArray) {
        return;
    }
    _titleOneArray[0][@"fill"] = [AppSkinColorManger sharedInstance].themeColor;
    _titleOneArray[1][@"fill"] = [AppSkinColorManger sharedInstance].secondColor;
    _titleOneArray[2][@"fill"] = [AppSkinColorManger sharedInstance].thirdColor;
    _titleOneArray[3][@"fill"] = [AppSkinColorManger sharedInstance].backgroundColor;
    _titleOneArray[4][@"fill"] = [AppSkinColorManger sharedInstance].animationOneColor;
}

- (void)createTableFootView {

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
    if (indexPath.section == 0) {
        StyleTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StyleTypeTableViewCellId forIndexPath:indexPath];
        [cell updateWithTitleString:_titleOneArray[indexPath.row][@"title"] ImageColor:_titleOneArray[indexPath.row][@"fill"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        StyleTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StyleTypeTableViewCellId forIndexPath:indexPath];
        [cell updateWithTitleString:_titleTwoArray[indexPath.row][@"title"] valueString:_titleTwoArray[indexPath.row][@"fill"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 35)];
        UILabel *headLable = [[UILabel alloc] init];
        headLable.text = @"颜色设置";
        headLable.font = [UIFont systemFontOfSize:15];
        headLable.textColor = [UIColor colorWithHexString:@"999999"];
        [headView addSubview:headLable];
        [headLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headView).offset(5);
            make.left.mas_equalTo(headView).offset(17);
        }];
        return headView;
    } else {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 35)];
        UILabel *headLable = [[UILabel alloc] init];
        headLable.text = @"样式设置";
        headLable.font = [UIFont systemFontOfSize:15];
        headLable.textColor = [UIColor colorWithHexString:@"999999"];
        [headView addSubview:headLable];
        [headLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headView).offset(5);
            make.left.mas_equalTo(headView).offset(17);
        }];
        return headView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = @"";
    if (indexPath.section == 0) {
        title = _titleOneArray[indexPath.row][@"title"];
    } else {
        title = _titleTwoArray[indexPath.row][@"title"];
    }
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(didselectStyleTypeTableViewCellWithTitle:indexSection:)]) {
        [_tableViewDelegate didselectStyleTypeTableViewCellWithTitle:title indexSection:indexPath.section];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 0.01)];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
