//
//  AddOneArticleTableView.m
//  SimpleRecord
//
//  Created by xia on 2018/4/23.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "AddOneArticleTableView.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import <Chameleon.h>
#import "Macro.h"

#define AddOneArticleTableViewCellId @"AddOneArticleTableViewCellId"

@interface AddOneArticleTableView()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
    NSString *_title;
    NSString *_content;
}
@property(nonatomic, strong) UITextField *titleText;
@property(nonatomic, strong) UITextView *contentView;
@end

@implementation AddOneArticleTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self createHeadView];
        [self registerTableViewCell];
    }
    return self;
}

- (void)updateWithModel:(RecordDataModel *)model {
    _title = model.title;
    _content = model.content;
    _titleText.text = _title;
}

- (void)createHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 70)];
    headView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    if (!_titleText) {
        _titleText = [[UITextField alloc] init];
        _titleText.delegate = self;
        _titleText.placeholder = @"请输入文章标题";
        _titleText.font = [UIFont systemFontOfSize:18];
        _titleText.textColor = [UIColor colorWithHexString:@"333"];
        _titleText.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:_titleText];
        [_titleText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headView);
            make.left.mas_offset(20);
            make.right.mas_offset(-20);
        }];
    }
    _titleText.text = _title;
    self.tableHeaderView = headView;
}

- (void)registerTableViewCell {
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:AddOneArticleTableViewCellId];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddOneArticleTableViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!_contentView) {
        _contentView = [[UITextView alloc] init];
        _contentView.delegate = self;
        _contentView.textContainerInset = UIEdgeInsetsMake(0, 0,0, 0);
        [_contentView setTextColor:[UIColor colorWithHexString:@"666"]];
        _contentView.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).offset(20);
            make.right.mas_equalTo(cell.contentView).offset(-20);
            make.top.mas_equalTo(cell.contentView).offset(8);
            make.bottom.mas_equalTo(cell.contentView).offset(-8);
        }];
    }
//    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.text = _content.length ? _content : @"在此键入你的文章内容";
    _contentView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHTOFSCREEN - 90 - 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 1)];
    headView.backgroundColor = [AppSkinColorManger sharedInstance].thirdColor;
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 20)];
    footView.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    return footView;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _title = textField.text;
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(tableViewDidEndEditingReturnTitle:content:)]) {
        [_tableViewDelegate tableViewDidEndEditingReturnTitle:_title content:_content];
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChangeSelection:(UITextView *)textView {
    _content = textView.text;
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(tableViewDidEndEditingReturnTitle:content:)]) {
        [_tableViewDelegate tableViewDidEndEditingReturnTitle:_title content:_content];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"在此键入你的文章内容"]) {
        textView.text = @"";
    }
    return YES;
}

@end
