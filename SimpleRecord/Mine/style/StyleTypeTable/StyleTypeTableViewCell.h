//
//  StyleTypeTableViewCell.h
//  SimpleRecord
//
//  Created by xia on 2018/4/4.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleTypeTableViewCell : UITableViewCell

- (void)updateWithTitleString:(NSString *)title ImageColorString:(NSString *)colorHex;

- (void)updateWithTitleString:(NSString *)title valueString:(NSString *)value;

@end
