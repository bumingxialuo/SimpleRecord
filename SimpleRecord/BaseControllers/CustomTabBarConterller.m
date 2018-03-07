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
}

#pragma mark getters and setters

-(void)createTabBarItemWithTitle:(NSString *)title withUnSelectedImage:(NSString *)unSelectedImage withSelectedImage:(NSString *)selectedImage withTag:(NSInteger)tag
{
    UIImage *image1_0 = [UIImage imageNamed:unSelectedImage];
    UIImage *image1_1 = [UIImage imageNamed:selectedImage];
    
    (void)[[self.tabBar.items objectAtIndex:tag] initWithTitle:title image:image1_0 selectedImage:image1_1];
    
    [[self.tabBar.items objectAtIndex:tag] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [AppSkinColorManger sharedInstance].themeColor, NSForegroundColorAttributeName,
                                                                   nil] forState:UIControlStateSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
