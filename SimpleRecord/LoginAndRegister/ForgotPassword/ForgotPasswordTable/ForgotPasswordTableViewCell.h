//
//  ForgotPasswordTableViewCell.h
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDCountDownButton.h"

typedef NS_ENUM(NSInteger, ForgotPwdViewTFType)
{
    ForgotPwdViewTFTypePhone = 0,
    ForgotPwdViewTFTypeGetVerificationCode = 1,
    ForgotPwdViewTFTypeNewPassword = 2,
    ForgotPwdViewTFTypeNewPasswordEnsure = 3
};
@protocol ForgotPasswordTableViewCellDelegate<NSObject>
- (void)getTextFieldContent:(NSString *)text forgotPwdType:(ForgotPwdViewTFType)type;
- (void)forgetViewSendValid:(RDCountDownButton *)sender;
@end

@interface ForgotPasswordTableViewCell : UITableViewCell

@property(nonatomic, weak) id<ForgotPasswordTableViewCellDelegate> cellDelegate;

- (void)updateWithPhone:(NSString *)phone;

- (void)updateWithTitleLabelString:(NSString *)title textFieldPlaceholserString:(NSString *)placeholder showCutDownButton:(BOOL)show passwordStringSecret:(BOOL)secret;
@end
