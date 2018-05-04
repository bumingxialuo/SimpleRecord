//
//  DiaryListTableView.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/15.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarListModel.h"
#import "RecordListModel.h"

@interface DiaryListTableView : UITableView

- (void)updateWithModel:(CalendarListModel *)model;

- (void)updateWithArticelModel:(RecordListModel *)model;

@end
