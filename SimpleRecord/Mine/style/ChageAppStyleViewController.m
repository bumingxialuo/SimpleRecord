//
//  ChageAppStyleViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChageAppStyleViewController.h"
#import "AppSkinColorManger.h"
#import "StyleTypeTableView.h"
#import <Masonry.h>

@interface ChageAppStyleViewController ()
@property(nonatomic, strong) StyleTypeTableView *tableView;
@end

@implementation ChageAppStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"样式设置";
    [self createSubView];
}

- (void)createSubView {
    _tableView = [[StyleTypeTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
