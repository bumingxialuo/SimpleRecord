//
//  MIneTableView.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/3/25.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineTableViewDelegate<NSObject>
- (void)mineTableViewDidSelectRowIndexRow:(NSInteger) index;

- (void)userDoLoginEvent;
@end

@interface MineTableView : UITableView
@property(nonatomic, weak) id<MineTableViewDelegate> tableViewDelegate;
@end
