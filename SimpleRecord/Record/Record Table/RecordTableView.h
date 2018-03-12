//
//  RecordTableView.h
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordTableViewDelegate<NSObject>

@end

@interface RecordTableView : UITableView
@property(nonatomic,weak) id<RecordTableViewDelegate> tableDelegate;
@end
