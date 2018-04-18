//
//  RegisterTableView.h
//  ZhongNuo
//
//  Created by xia on 2018/4/10.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDCountDownButton.h"
//#import "RegisterDataModel.h"

@protocol RegisterTableViewDelegate<NSObject>

- (void)registerButtonIntableViewClick:(UIButton *)sender Param:(NSDictionary *)param;

- (void)registerTableViewSendValidCodeWithPhone:(NSString *)phone sender:(RDCountDownButton *)sender;

- (void)registViewSelectArgreeWithTitle:(NSString *)title urlString:(NSString *)url;

@end

@interface RegisterTableView : UITableView
@property(nonatomic, weak) id<RegisterTableViewDelegate> tableViewDelegate;

- (void)updatePhoneNumber:(NSString *)phone;

//- (void)updateWithDataModel:(RegisterDataModel *)model;

@end
