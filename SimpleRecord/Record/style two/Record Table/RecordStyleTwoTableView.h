//
//  RecordStyleTwoTableVIew.h
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordDataModel.h"

@protocol RecordStyleTwoTableViewDelegate<NSObject>
- (void)turnToContinumEditingArticleViewWithId:(NSString *)articleId;
@end

@interface RecordStyleTwoTableView : UITableView
@property(nonatomic, weak) id<RecordStyleTwoTableViewDelegate> tableViewDelegate;
- (void)updateWithModel:(RecordDataModel *)model;
@end
