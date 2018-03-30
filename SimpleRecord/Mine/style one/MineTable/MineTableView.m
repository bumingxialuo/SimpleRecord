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

#define MineTableViewCellId @"MineTableViewCellId"

@interface MineTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.delegate = self;
        self.dataSource = self;
        [self createHeadView];
        [self registerTableViewCell];
    }
    return self;
}

- (void)createHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 180)];
    headView.backgroundColor = [UIColor whiteColor];
    
    self.tableHeaderView = headView;
}

- (void)registerTableViewCell {
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:MineTableViewCellId];
}

#pragma mark - UItableViewDelegate And UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"你好啊你好啊你好啊";
    return cell;
}

@end
