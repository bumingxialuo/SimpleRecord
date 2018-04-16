//
//  AddCalendarTableView.m
//  SimpleRecord
//
//  Created by xia on 2018/4/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "AddCalendarTableView.h"
#import "AppSkinColorManger.h"
#import <Masonry.h>
#import "Macro.h"
#import <Chameleon.h>
#import <YYText.h>

#define AddCalendarTableViewCellId @"AddCalendarTableViewCellId"

@interface AddCalendarTableView()<UITableViewDelegate, UITableViewDataSource, YYTextViewDelegate, UIGestureRecognizerDelegate>
{
    CGFloat _contentHeight;
    NSString *_dateString;
}
@property(nonatomic, strong) YYTextView *textView;
@end

@implementation AddCalendarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
//        self.separatorColor = [UIColor redColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self addNotification];
        [self setUpData];
        [self registerCell];
        [self addTapGesture];
    }
    return self;
}
- (void)updateWithDataModel:(CalendarDataModel *)model {
    if (!model) {
        [_textView setEditable:YES];
        [_textView resignFirstResponder];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
        _dateString = dateStr;
    } else {
        _textView.text = model.content;
        _dateString = [model.date substringFromIndex:model.date.length-5];
    }
}

- (void)setUpData {
    _contentHeight = 300;
}
- (void)registerCell {
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:AddCalendarTableViewCellId];
}
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidHidden)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}
#pragma mark - UITableViewDelegate And UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddCalendarTableViewCellId];
    cell.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(0, 0,0, 0);
        [_textView setTextColor:[UIColor colorWithHexString:@"666"]];
        _textView.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).offset(20);
            make.right.mas_equalTo(cell.contentView).offset(-20);
            make.top.mas_equalTo(cell.contentView).offset(8);
            make.bottom.mas_equalTo(cell.contentView).offset(-8);
        }];
    }
    _textView.backgroundColor = [UIColor whiteColor];
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).offset(20);
        make.right.mas_equalTo(cell.contentView).offset(-20);
        make.top.mas_equalTo(cell.contentView).offset(8);
        make.bottom.mas_equalTo(cell.contentView).offset(-8);
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHTOFSCREEN - 40 - 70 - 64;
//    return _contentHeight + 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 70)];
    UILabel *tipL = [[UILabel alloc] init];
    tipL.textColor = [UIColor colorWithHexString:@"999"];
    tipL.text = [NSString stringWithFormat:@"ToDay: %@",_dateString];
    [headView addSubview:tipL];
    [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(20);
        make.right.mas_equalTo(headView).offset(-20);
        make.centerY.mas_equalTo(headView);
    }];
    UIView *sepearLine = [[UIView alloc] init];
    sepearLine.backgroundColor = [AppSkinColorManger sharedInstance].secondColor;
    [headView addSubview:sepearLine];
    [sepearLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipL);
        make.width.mas_equalTo(WIDTHOFSCREEN - 40);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(headView).offset(-5);
    }];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 30)];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}
#pragma YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView {
    CGSize constraintSize =CGSizeMake(WIDTHOFSCREEN -40, MAXFLOAT);
    //计算高度
//    CGSize size = [textView sizeThatFits:constraintSize];
//    if (size.height > 300) {
//        _contentHeight = size.height;
//        [self beginUpdates];
//        [self endUpdates];
//    }
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    if (_tableViewDelegate && [_tableViewDelegate respondsToSelector:@selector(getCalendarContextWithContext:)]) {
        [_tableViewDelegate getCalendarContextWithContext:textView.text];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YYTextView"]) {
        return NO;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YYTextContainerView"]) {
        return NO;
    }
    
    return YES;
}

- (void) handleKeyboardDidShow : (NSNotification*)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; //获得键盘的rect
    //通过rect做响应的弹起等
    float offsetY = HEIGHTOFSCREEN - CGRectGetMaxY(_textView.frame);
    if (offsetY < keyboardFrame.size.height) {
        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-keyboardFrame.size.height - 20);
        }];
    }
}

- (void)handleKeyboardDidHidden {
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.mas_offset(8);
        make.bottom.mas_offset(-8);
    }];
}

- (void)hiddenKeyboard {
    [self endEditing:YES];
}

@end
