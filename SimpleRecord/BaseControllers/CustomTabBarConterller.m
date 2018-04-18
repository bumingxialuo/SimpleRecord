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
#import "SwitchConfigurationManager.h"
#import <HHRouter/HHRouter.h>
#import "SRRouterUrl.h"
#import "UIImage+color.h"
#import "NOTICE.h"
#import "SRAppUserProfile.h"

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
    [self registerNotice];
    [self settingStyle];
    [self createSubVC];
}

- (void)settingStyle {
    [self.tabBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    [self.tabBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    [self.tabBar setTintColor:[AppSkinColorManger sharedInstance].themeColor];
}

- (void)registerNotice
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLogOut)
                                                 name:NOTICE_UserLogOut
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLogIn)
                                                 name:NOTICE_UserLogIn
                                               object:nil];
}

-(void)userLogOut
{
    [[SRAppUserProfile sharedInstance] cleanUp];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UINavigationController *nav = self.selectedViewController;
        [nav popToRootViewControllerAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            self.selectedIndex = 0;
            [self userLogIn];
        });
    });
}

/**
 用户登录
 */
- (void)userLogIn
{
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:[[HHRouter shared] matchController:SR_LoginAndRegister_Login]];
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (void)createSubVC {
    _calendarNav = [[CustomNavigationController alloc] init];
    if ([SwitchConfigurationManager sharedInstance].SwichConfigurationRecord) {
        _recodNav = [[CustomNavigationController alloc] init];
    }
    _mineNav = [[CustomNavigationController alloc] init];
    
    if (_calendarNav) {
        if ([SwitchConfigurationManager sharedInstance].RecordStyleValue == CalendarStyleOne) {
            UIViewController *vc = [[HHRouter shared] matchController:SR_Calendar];
            _calendarNav.viewControllers = @[vc];
        } else if ([SwitchConfigurationManager sharedInstance].RecordStyleValue == CalendarStyleTwo) {
            UIViewController *vc = [[HHRouter shared] matchController:SR_CalendarStyleTwo];
            _calendarNav.viewControllers = @[vc];
        }
        
    }
    if (_recodNav) {
        if ([SwitchConfigurationManager sharedInstance].RecordStyleValue == RecordTypeSimpleTable) {
            UIViewController *vc = [[HHRouter shared] matchController:SR_Record];
            _recodNav.viewControllers = @[vc];
        } else if ([SwitchConfigurationManager sharedInstance].RecordStyleValue == RecordTypeAnimationTable) {
            UIViewController *vc = [[HHRouter shared] matchController:SR_RecordStyleTwo];
            _recodNav.viewControllers = @[vc];
        }
        
    }
    if (_mineNav) {
        UIViewController *vc = [[HHRouter shared] matchController:SR_Mine];
        _mineNav.viewControllers = @[vc];
    }
    if ([SwitchConfigurationManager sharedInstance].SwichConfigurationRecord) {
        self.viewControllers = @[_calendarNav,_recodNav,_mineNav];
    } else {
        self.viewControllers = @[_calendarNav,_mineNav];
    }
    [self createTabBarItemWithTitle:@"日历" withUnSelectedImage:@"calendar_unSelect" withSelectedImage:@"calendar_select" withTag:0];
    if ([SwitchConfigurationManager sharedInstance].SwichConfigurationRecord) {
        [self createTabBarItemWithTitle:@"记录" withUnSelectedImage:@"record_unSelect" withSelectedImage:@"record_select" withTag:1];
    }
    [self createTabBarItemWithTitle:@"我的" withUnSelectedImage:@"mine_unSelect" withSelectedImage:@"mine_select" withTag:2];
}


-(void)createTabBarItemWithTitle:(NSString *)title withUnSelectedImage:(NSString *)unSelectedImage withSelectedImage:(NSString *)selectedImage withTag:(NSInteger)tag
{
    UIImage *image1_0 = [UIImage imageNamed:unSelectedImage];
    UIImage *image1_1 = [UIImage imageNamed:selectedImage];
    
    UIImage *unSelectImage_handle = [image1_0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage_handle = [image1_1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    
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
