//
//  RegisterTableViewCell.h
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDCountDownButton.h"

typedef NS_ENUM(NSInteger, RegisterViewTFType)
{
    RegisterViewTFTypePhone = 0,
    RegisterViewTFTypeGetVerificationCode = 1,
    RegisterViewTFTypePassword = 2,
    RegisterViewTFTypePasswordEnsure = 3
};

@protocol RegisterTableViewCellDelegate <NSObject>
- (void)registerViewSendValidCode:(RDCountDownButton *)sender;

- (void)getTitleTextFeildContent:(NSString *)title registerType:(RegisterViewTFType)type;
@end

@interface RegisterTableViewCell : UITableViewCell
@property(nonatomic, weak) id<RegisterTableViewCellDelegate> cellDelegate;
- (void)updateWithPhone:(NSString *)phone;
- (void)updateWithIconName:(NSString *)icon placeHolderString:(NSString *)placeholder isHiddenGetCodeBtn:(BOOL)isHidden passWord:(BOOL)isPassWord;
@end
