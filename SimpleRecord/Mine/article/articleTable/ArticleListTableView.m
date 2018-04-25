//
//  ArticleListTableView.m
//  SimpleRecord
//
//  Created by xia on 2018/4/25.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ArticleListTableView.h"

@interface ArticleListTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ArticleListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

//- hei

@end
