//
//  CalendarViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "CalendarViewController.h"
#import "AppSkinColorManger.h"
#import "CCPCalendarView.h"
#import <Masonry.h>

@interface CalendarViewController ()
@property(nonatomic, strong) CCPCalendarView *calendarView;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].thirdColor;
    self.navigationItem.title = @"00月00日";
    [self createSubview];
}

- (void)createSubview {
    _calendarView = [[CCPCalendarView alloc] init];
    [_calendarView initSubviews];
    [self.view addSubview:_calendarView];
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
