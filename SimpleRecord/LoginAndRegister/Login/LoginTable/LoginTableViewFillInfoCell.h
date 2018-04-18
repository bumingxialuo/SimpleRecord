//
//  LoginTableViewFillInfoCell.h
//  ZhongNuo
//
//  Created by xia on 2018/4/9.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RightViewType)
{
    RightViewTypePasswordVisible = 0,
    RightViewTypeGetVerificationCode = 1,
    RightViewTypeGraphicVerification = 2,
    RightViewTypeNone
};

@protocol LoginTableViewFillInfoCellDelegate<NSObject>
- (void)toObtainRitghtWithType:(RightViewType)type titltString:(NSString *)title;
@end

@interface LoginTableViewFillInfoCell : UITableViewCell
@property(nonatomic, weak) id<LoginTableViewFillInfoCellDelegate> cellDelegate;
- (void)updateWithIconImageString:(NSString *)icon titlePlaceHolderString:(NSString *)placeHolder rightButtonType:(RightViewType)type;
- (void)updateCaptchViewImage:(NSData *)imageData;
- (void)selectedCellChangeLineColor:(BOOL)isSelected;

@end
