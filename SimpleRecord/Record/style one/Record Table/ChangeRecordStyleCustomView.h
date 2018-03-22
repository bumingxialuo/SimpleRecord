//
//  ChangeRecordStyleCustomView.h
//  SimpleRecord
//
//  Created by xia on 2018/3/14.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeRecordStyleCustomViewDelegate<NSObject>
- (void)clickAddButton;
@end
@interface ChangeRecordStyleCustomView : UIView

@property(nonatomic, weak) id<ChangeRecordStyleCustomViewDelegate> viewDelegate;

@end
