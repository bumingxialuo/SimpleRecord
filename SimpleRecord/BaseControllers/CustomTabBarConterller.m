//
//  CustomTabBarConterller.m
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "CustomTabBarConterller.h"
#import "CustomNavigationController.h"
#import "AppSkinColorManger.h"
#import <HHRouter/HHRouter.h>
#import "SRRouterUrl.h"
#import "UIImage+color.h"

@interface CustomTabBarConterller ()
@property(nonatomic,strong) CustomNavigationController *calendarNav;
@property(nonatomic,strong) CustomNavigationController *recodNav;
@property(nonatomic,strong) CustomNavigationController *mineNav;
@end

@implementation CustomTabBarConterller

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingStyle];
    [self createSubVC];
}

- (void)settingStyle {
    [self.tabBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    [self.tabBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
}

- (void)createSubVC {
    _calendarNav = [[CustomNavigationController alloc] init];
    _recodNav = [[CustomNavigationController alloc] init];
    _mineNav = [[CustomNavigationController alloc] init];
    
    if (_calendarNav) {
        UIViewController *vc = [[HHRouter shared] matchController:SR_Calendar];
        _calendarNav.viewControllers = @[vc];
    }
    if (_recodNav) {
        UIViewController *vc = [[HHRouter shared] matchController:SR_Record];
        _recodNav.viewControllers = @[vc];
    }
    if (_mineNav) {
        UIViewController *vc = [[HHRouter shared] matchController:SR_Mine];
        _mineNav.viewControllers = @[vc];
    }
    self.viewControllers = @[_calendarNav,_recodNav,_mineNav];
    [self createTabBarItemWithTitle:@"日历" withUnSelectedImage:@"calendar_unSelect" withSelectedImage:@"calendar_select" withTag:0];
    [self createTabBarItemWithTitle:@"记录" withUnSelectedImage:@"record_unSelect" withSelectedImage:@"record_select" withTag:1];
    [self createTabBarItemWithTitle:@"我的" withUnSelectedImage:@"mine_unSelect" withSelectedImage:@"mine_select" withTag:2];
}

#pragma mark - getters and setters

-(void)createTabBarItemWithTitle:(NSString *)title withUnSelectedImage:(NSString *)unSelectedImage withSelectedImage:(NSString *)selectedImage withTag:(NSInteger)tag
{
    UIImage *image1_0 = [UIImage imageNamed:unSelectedImage];
    UIImage *image1_1 = [UIImage imageNamed:selectedImage];
    
    UIImage *unSelectImage_handle = [image1_0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage_handle = [image1_1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    (void)[[self.tabBar.items objectAtIndex:tag] initWithTitle:title image:unSelectImage_handle selectedImage:selectImage_handle];
    
    [[self.tabBar.items objectAtIndex:tag] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [AppSkinColorManger sharedInstance].themeColor, NSForegroundColorAttributeName,
                                                                   nil] forState:UIControlStateSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
