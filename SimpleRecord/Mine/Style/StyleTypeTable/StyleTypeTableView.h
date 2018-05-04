//
//  StyleTypeTableView.h
//  SimpleRecord
//
//  Created by xia on 2018/4/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StyleTypeTableViewDelegate<NSObject>

- (void)didselectStyleTypeTableViewCellWithTitle:(NSString *)title indexSection:(NSInteger)section;

@end

@interface StyleTypeTableView : UITableView
- (void)updataColor;
@property(nonatomic, weak) id<StyleTypeTableViewDelegate> tableViewDelegate;

@end
