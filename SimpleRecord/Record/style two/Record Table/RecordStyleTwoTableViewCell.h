//
//  RecordStyleTwoTableViewCell.h
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationType) {
    AnimationTypeOpen,
    AnimationTypeClose
};

@interface RecordStyleTwoTableViewCell : UITableViewCell

@property(nonatomic, assign) IBInspectable NSInteger itemCount;
@property(nonatomic, strong) IBInspectable UIColor *backViewColor;

- (BOOL)isAnimating;

- (NSTimeInterval)animationDurationWithItemIndex:(NSInteger)itemIndex animationType:(AnimationType)type;

- (void)selectedAnimationByIsSelected:(BOOL)isSelected animated:(BOOL)animated completion:(void(^)())completion;

- (void)setNumber:(NSInteger)number;
@end
