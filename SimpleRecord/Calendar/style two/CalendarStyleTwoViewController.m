//
//  CalendarStyleTwoViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "CalendarStyleTwoViewController.h"
#import "ZYCalendarView.h"
#import "AppSkinColorManger.h"
#import <ChameleonFramework/Chameleon.h>
#import "SRRouterUrl.h"
#import <HHRouter/HHRouter.h>

@interface CalendarStyleTwoViewController ()

@end

@implementation CalendarStyleTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    [self createRightItem];
    [self createSubView];
}

- (void)createRightItem {
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)createSubView {
    UIView *weekTitlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:weekTitlesView];
    CGFloat weekW = self.view.frame.size.width/7;
    NSArray *titles = @[@"日", @"一", @"二", @"三",
                        @"四", @"五", @"六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(i*weekW, 20, weekW, 44)];
        week.textAlignment = NSTextAlignmentCenter;
        
        [weekTitlesView addSubview:week];
        week.text = titles[i];
    }
    
    
    ZYCalendarView *view = [[ZYCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    // 不可以点击已经过去的日期
    view.manager.canSelectPastDays = false;
    view.manager.disableTextColor = [UIColor colorWithHexString:@"999"];
    // 可以选择时间段
    view.manager.selectionType = ZYCalendarSelectionTypeSingle;
    
    // 设置被选中颜色
    view.manager.selectedBackgroundColor = [AppSkinColorManger sharedInstance].themeColor;
    
    // 设置当前日期 请在所有参数设置完之后设置日期
    view.date = [NSDate date];
    
    self.navigationItem.title = [view.manager.dateFormatter stringFromDate:[NSDate date]];
    
    view.dayViewBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
        // NSLog(@"%@", dayDate);
        for (NSDate *date in manager.selectedDateArray) {
            NSLog(@"%@", [manager.dateFormatter stringFromDate:date]);
        }
        self.navigationItem.title = [manager.dateFormatter stringFromDate:manager.selectedDateArray[0]];
        printf("\n");
    };
    
    [self.view addSubview:view];
}

- (void)addButtonClick {
    UIViewController *vc = [[HHRouter shared] matchController:SR_Calendar_AddDiary];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
