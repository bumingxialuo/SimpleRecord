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
    }
    return self;
}

#pragma mark - set data
- (void)setupData {
    _titleOneArray = [[NSMutableArray alloc] initWithCapacity:0];
    _titleTwoArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic1 setObject:@"主题色" forKey:@"title"];
    [dic1 setObject:[AppSkinColorManger sharedInstance].themeColor forKey:@"fill"];
    [dic1 setObject:@"" forKey:@"desc"];
    [dic1 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic2 setObject:@"第一辅色" forKey:@"title"];
    [dic2 setObject:[AppSkinColorManger sharedInstance].secondColor forKey:@"fill"];
    [dic2 setObject:@"" forKey:@"desc"];
    [dic2 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic3 setObject:@"第二辅色" forKey:@"title"];
    [dic3 setObject:[AppSkinColorManger sharedInstance].thirdColor forKey:@"fill"];
    [dic3 setObject:@"" forKey:@"desc"];
    [dic3 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic4 setObject:@"背景色" forKey:@"title"];
    [dic4 setObject:[AppSkinColorManger sharedInstance].backgroundColor forKey:@"fill"];
    [dic4 setObject:@"" forKey:@"desc"];
    [dic4 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic5 setObject:@"动画色" forKey:@"title"];
    [dic5 setObject:[AppSkinColorManger sharedInstance].animationOneColor forKey:@"fill"];
    [dic5 setObject:@"" forKey:@"desc"];
    [dic5 setObject:@(YES) forKey:@"click"];
    
    [_titleOneArray addObject:dic1];
    [_titleOneArray addObject:dic2];
    [_titleOneArray addObject:dic3];
    [_titleOneArray addObject:dic4];
    [_titleOneArray addObject:dic5];
    
    NSDictionary *dic11 = @{@"title":@"文章开关",@"fill":@"开启",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic12 = @{@"title":@"日记方案",@"fill":@"方案二",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic13 = @{@"title":@"文章方案",@"fill":@"动画方案",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic14 = @{@"title":@"我的方案",@"fill":@"列表方案",@"desc":@"",@"click":@(YES)};
    
    [_titleTwoArray addObject:dic11];
    [_titleTwoArray addObject:dic12];
    [_titleTwoArray addObject:dic13];
    [_titleTwoArray addObject:dic14];
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
//    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 80)];
//    footView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
//    UILabel *tipL = [[UILabel alloc] init];
//    tipL.numberOfLines = 0;
//    tipL.text = @"点击";
}

#pragma mark - UITableViewDelegate And UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self setupData];
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
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(didselectStyleTypeTableViewCellForIndepath:)]) {
        [_tableViewDelegate didselectStyleTypeTableViewCellForIndepath:indexPath];
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
