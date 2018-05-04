//
//  ChangeAppFunctionViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/5/2.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChangeAppFunctionViewController.h"
#import "SRRouterManager.h"
#import "AppSkinColorManger.h"

@interface ChangeAppFunctionViewController ()
{
    NSString *_title;
}
@end

@implementation ChangeAppFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
    self.navigationItem.title = _title;
}

- (void)setParams:(NSDictionary *)params {
    _title = params[@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
