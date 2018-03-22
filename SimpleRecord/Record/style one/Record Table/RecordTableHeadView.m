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
#import "ChangeRecordStyleCustomView.h"

@interface RecordTableHeadView()
@property(nonatomic, strong) ChangeRecordStyleCustomView *view;
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
    
}

@end
