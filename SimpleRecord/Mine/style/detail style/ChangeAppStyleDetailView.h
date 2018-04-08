//
//  ChangeAppStyleDetailView.h
//  SimpleRecord
//
//  Created by xia on 2018/4/8.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SRColorStyle {
    SRColorStyleTheme = 0,                 //主题色
    SRColorStyleSecond = 1,                //第一辅色
    SRColorStyleThird = 2,                 //第二辅色
    SRColorStyleBackground = 3,            //背景色
    SRColorStyleAnimation = 4,             //动画色
}SRColorStyle;

@protocol ChangeAppStyleDetailViewDelegate<NSObject>
- (void)sliderViewEndTapWithAllColor:(NSArray<UIColor *> *)colors;
@end

@interface ChangeAppStyleDetailView : UIView
- (instancetype)initViewWithType:(SRColorStyle)type;
@property(nonatomic, weak) id<ChangeAppStyleDetailViewDelegate> viewDelegate;
@end
