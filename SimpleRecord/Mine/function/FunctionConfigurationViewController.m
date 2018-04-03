//
//  FunctionConfigurationViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "FunctionConfigurationViewController.h"
#import "AppSkinColorManger.h"

@interface FunctionConfigurationViewController ()

@end

@implementation FunctionConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.title = @"功能配置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
