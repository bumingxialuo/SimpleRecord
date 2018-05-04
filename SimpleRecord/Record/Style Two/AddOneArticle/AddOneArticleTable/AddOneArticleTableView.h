//
//  AddOneArticleTableView.h
//  SimpleRecord
//
//  Created by xia on 2018/4/23.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordDataModel.h"

@protocol AddOneArticleTableViewDelegate<NSObject>
- (void)tableViewDidEndEditingReturnTitle:(NSString *)title content:(NSString *)content;
@end

@interface AddOneArticleTableView : UITableView
@property(nonatomic, weak) id<AddOneArticleTableViewDelegate> tableViewDelegate;
- (void)updateWithModel:(RecordDataModel *)model;
@end
