//
//  RecordTableHeadView.m
//  SimpleRecord
//
//  Created by xia on 2018/3/12.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordTableHeadView.h"
#import <Masonry/Masonry.h>
#import "AppSkinColorManger.h"
#import <ChameleonFramework/Chameleon.h>

@interface RecordTableHeadView()

@end

@implementation RecordTableHeadView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createHeadSubView];
    }
    return self;
}

- (void)createHeadSubView {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
}

- (void)addButtonClick:(UIButton *)sender {
    //卡片折叠效果  日记+文章
    
}

- (void)createSubView {
    UIView *diaryAddView = [[UIView alloc] init];
    UIView *articleAddView = [[UIView alloc] init];
    diaryAddView.backgroundColor = [AppSkinColorManger sharedInstance].themeColor;
    articleAddView.backgroundColor = [AppSkinColorManger sharedInstance].themeColor;
    
}

@end
