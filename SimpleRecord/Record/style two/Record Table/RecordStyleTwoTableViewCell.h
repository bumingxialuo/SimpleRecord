//
//  RecordStyleTwoTableViewCell.h
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordDataModel.h"

typedef NS_ENUM(NSInteger,AnimationType) {
    AnimationTypeOpen,
    AnimationTypeClose
};

@protocol RecordStyleTwoTableViewCellDelegate<NSObject>
- (void)turnToArticleDetailViewWithId:(NSString *)articleId;
@end

@interface RecordStyleTwoTableViewCell : UITableViewCell

@property(nonatomic, weak) id<RecordStyleTwoTableViewCellDelegate> cellDelegate;

@property(nonatomic, assign) IBInspectable NSInteger itemCount;
@property(nonatomic, strong) IBInspectable UIColor *backViewColor;

- (void)updateWithModel:(RecordDataModel *)model;

- (BOOL)isAnimating;

- (NSTimeInterval)animationDurationWithItemIndex:(NSInteger)itemIndex animationType:(AnimationType)type;

- (void)selectedAnimationByIsSelected:(BOOL)isSelected animated:(BOOL)animated completion:(void(^)())completion;

- (void)setNumber:(NSInteger)number;
@end
