//
//  RecordTableView.m
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordTableView.h"
#import "AppSkinColorManger.h"
#import "ChangeRecordStyleCustomView.h"
#import "Macro.h"
#import "RecordTableViewCell.h"
#import <Masonry/Masonry.h>

#define RecordTableViewCellID @"RecordTableViewCellID"

@interface RecordTableView()<UITableViewDelegate, UITableViewDataSource, ChangeRecordStyleCustomViewDelegate>

@property(nonatomic, strong) ChangeRecordStyleCustomView *headView;

@end

@implementation RecordTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerTableCellClass];
    }
    return self;
}

- (void)registerTableCellClass {
    [self registerClass:[RecordTableViewCell class] forCellReuseIdentifier:RecordTableViewCellID];
}

#pragma mark - CustomDelegate

- (void)clickAddButton {
//    _headView.backgroundColor = [AppSkinColorManger sharedInstance].highlightColor;
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headContainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 128)];
    _headView = [[ChangeRecordStyleCustomView alloc] init];
    _headView.viewDelegate = self;
    _headView.layer.masksToBounds = YES;
    _headView.layer.cornerRadius = 5.0;
    [headContainView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    return headContainView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 128;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordTableViewCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat value = (90.0 * M_PI) / 180.0;
    CATransform3D rotate = CATransform3DMakeRotation(value, 0.0, 0.7, 0.4);
    rotate.m34 = 1.0 / -600;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotate;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:1.0];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}
@end
