//
//  ChangeAppStyleDetailViewController.m
//  SimpleRecord
//
//  Created by xia on 2018/4/8.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "ChangeAppStyleDetailViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import <Masonry.h>
#import "UIImage+color.h"
#import "AppSkinColorManger.h"
#import "SRRouterManager.h"
#import "ChangeAppStyleDetailView.h"

@interface ChangeAppStyleDetailViewController ()<ChangeAppStyleDetailViewDelegate>
{
    NSString *_title;
    UIColor *_saveColor;
    SRColorStyle _style;
}

@property(nonatomic, strong) ChangeAppStyleDetailView *mainView;

@end

@implementation ChangeAppStyleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _title;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpdata];
    [self createSaveButton];
    [self createSubView];
    
}

- (void)setParams:(NSDictionary *)params {
    _title = params[@"title"];
}

- (void)setUpdata {
    if ([_title isEqualToString:@"主题色"]) {
        _style = SRColorStyleTheme;
    }
    else if ([_title isEqualToString:@"第一辅色"]) {
        _style = SRColorStyleSecond;
    }
    else if ([_title isEqualToString:@"第二辅色"]) {
        _style = SRColorStyleThird;
    }
    else if ([_title isEqualToString:@"背景色"]) {
        _style = SRColorStyleBackground;
    }
    else if ([_title isEqualToString:@"动画色"]) {
        _style = SRColorStyleAnimation;
    }
}

- (void)createSubView {
    _mainView = [[ChangeAppStyleDetailView alloc] initViewWithType:_style];
    _mainView.viewDelegate = self;
    [self.view addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_mainView layoutSubviews];
}

- (void)createSaveButton {
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)saveButtonClick {
    [self setUpColorInstanceData];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setUpColorInstanceData {
    if (_style == SRColorStyleTheme) {
        [AppSkinColorManger sharedInstance].themeColor = _saveColor;
    }
    else if (_style == SRColorStyleSecond) {
        [AppSkinColorManger sharedInstance].secondColor = _saveColor;
    }
    else if (_style == SRColorStyleThird) {
        [AppSkinColorManger sharedInstance].thirdColor = _saveColor;
    }
    else if (_style == SRColorStyleBackground) {
        [AppSkinColorManger sharedInstance].backgroundColor = _saveColor;
    }
    else if (_style == SRColorStyleAnimation) {
        [AppSkinColorManger sharedInstance].animationOneColor = _saveColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ChangeAppStyleDetailViewDelegate
- (void)sliderViewEndTapWithAllColor:(NSArray<UIColor *> *)colors {
    _saveColor = colors[0];
}

@end
