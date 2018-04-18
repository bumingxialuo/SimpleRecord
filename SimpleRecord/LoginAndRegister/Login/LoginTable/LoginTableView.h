//
//  LoginTableView.h
//  ZhongNuo
//
//  Created by xia on 2018/4/9.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginTableViewDelegate<NSObject>
- (void)closeButtonInTableClick;
- (void)loginButtonClick:(UIButton *)sender Phone:(NSString *)phone password:(NSString *)password picCode:(NSString *)code;
- (void)forgotPasswordButtonClickInTableView:(NSString *)phone;
- (void)registerButtonClickInTableView:(NSString *)phone;
@end

@interface LoginTableView : UITableView
- (void)updateWithCaptchaData:(NSDictionary *)imageData;
@property(nonatomic, weak) id<LoginTableViewDelegate> tableViewDelegate;
@end
