//
//  DiaryListViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "DiaryListViewController.h"
#import "AppSkinColorManger.h"

@interface DiaryListViewController ()

@end

@implementation DiaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"日记列表";
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
