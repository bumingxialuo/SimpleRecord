//
//  RegisterViewController.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/17.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RegisterViewController.h"
#import "SRRouterManager.h"
#import "RegisterTableView.h"
#import <Masonry.h>
#import "AppSkinColorManger.h"

@interface RegisterViewController ()
{
    NSString *_phone;
}
@property(nonatomic, strong) RegisterTableView *tableView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = @"注册";
    [self createTableView];
}

- (void)setParams:(NSDictionary *)params {
    _phone = params[@"phone"];
    if ([_phone isEqualToString:@"**"]) {
        _phone = @"";
    }
}

- (void)createTableView {
    _tableView = [[RegisterTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
