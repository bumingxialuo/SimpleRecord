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
}
@property(nonatomic, strong) YYTextView *textView;
@end

@implementation AddCalendarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.separatorColor = [UIColor redColor];
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self addNotification];
        [self registerCell];
        [self addTapGesture];
    }
    return self;
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
    _textView = [[YYTextView alloc] init];
    _textView.delegate = self;
    _textView.scrollEnabled = NO;
    _textView.textContainerInset = UIEdgeInsetsMake(0, 0,0, 0);
    [_textView setTextColor:[UIColor colorWithHexString:@"666"]];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.placeholderText = @"输入你的内容";
    _textView.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).offset(20);
        make.right.mas_equalTo(cell.contentView).offset(-20);
        make.top.mas_equalTo(cell.contentView).offset(8);
        make.height.mas_equalTo(30);
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _contentHeight ? _contentHeight+20 : 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, 70)];
    UILabel *tipL = [[UILabel alloc] init];
    tipL.textColor = [UIColor colorWithHexString:@"999"];
    tipL.text = @"jjfjfjfisifjisoishhoibhb";
    [headView addSubview:tipL];
    [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).offset(20);
        make.right.mas_equalTo(headView).offset(-20);
        make.centerY.mas_equalTo(headView);
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
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <=30) {
        self.contentHeight =30;
    } else {
        self.contentHeight = size.height;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([touch.view isKindOfClass:[YYTextView class]]) {
//        return NO;
//    }
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YYTextContainerView"]) {
        return NO;
    }
    return YES;
}

- (void)setContentHeight:(float)contentHeight{
    if (_contentHeight != contentHeight) {
        _contentHeight = contentHeight;
        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentHeight);
        }];
        [self layoutIfNeeded];
        //把高度赋值给model
        //刷新cell的高度（在此不能用reloadData,会造成输入失去焦点,你可以试一下）
        [self beginUpdates];
        [self endUpdates];
    }
}


- (void) handleKeyboardDidShow : (NSNotification*)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; //获得键盘的rect
    //通过rect做响应的弹起等
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0));
    }];
    [self layoutIfNeeded];
}

- (void)handleKeyboardDidHidden {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self layoutIfNeeded];
}

- (void)hiddenKeyboard {
    [self endEditing:YES];
}

@end
