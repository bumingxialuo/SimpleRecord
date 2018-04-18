//
//  ForgotPasswordTableView.h
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDCountDownButton.h"

@protocol ForgotPasswordTableViewDelegate<NSObject>
- (void)nextButtonInTableViewClick:(UIButton *)sender
                             Phone:(NSString *)phone
                              code:(NSString *)code
                          password:(NSString *)password
                    passwordEnsure:(NSString *)check;
- (void)forgetTableViewSendValidCode:(NSString *)phone sender:(RDCountDownButton *)sender;
@end

@interface ForgotPasswordTableView : UITableView
@property(nonatomic, weak) id<ForgotPasswordTableViewDelegate> tableViewDelegate;

- (void)updateWithPhone:(NSString *)phone;
@end
