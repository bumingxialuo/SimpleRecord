//
//  CustomNavigationController.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "CustomNavigationController.h"
#import "AppSkinColorManger.h"
#import <ChameleonFramework/Chameleon.h>
#import "UIImage+color.h"

@interface CustomNavigationController ()
@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [self createLeftItemWithImage:[UIImage imageNamed:@"back"]];
    [self showNormalNavigationBarTintColor:[AppSkinColorManger sharedInstance].themeColor];
}

- (void)showNormalNavigationBarTintColor:(UIColor *)tintColor
{
    self.navigationBar.tintColor = tintColor;
    [self setNavigationBarBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"FFFFFF"]]];
    NSDictionary *dict=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithHexString:@"333333"],[UIFont systemFontOfSize:20.0],[[NSShadow alloc] init],nil]forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName,NSShadowAttributeName,nil]];
    self.navigationBar.titleTextAttributes = dict;
    self.navigationBar.tintColor = [UIColor colorWithHexString:@"333333"];
}

- (void)setNavigationBarBackgroundImage:(UIImage *)bgImage
{
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)createLeftItemWithImage:(UIImage *) leftImage{
    if (self.viewControllers>0) {
        // 自定义导航栏左侧按钮
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        leftBtn.frame = CGRectMake(0, 0, 32, 32);
        [leftBtn setImage:leftImage forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)onTap {
    [self popViewControllerAnimated:YES];
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
