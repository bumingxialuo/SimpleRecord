//
//  DiaryListTableViewCell.h
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/16.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryListTableViewCell : UITableViewCell
- (void)updateWithTitle:(NSString *)title value:(NSString *)value isOpen:(BOOL)isOpen;
@end
