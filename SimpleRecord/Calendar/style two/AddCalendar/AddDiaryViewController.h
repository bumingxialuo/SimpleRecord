//
//  AddDiaryViewController.h
//  SimpleRecord
//
//  Created by xia on 2018/4/8.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CalendarOperationStyle)
{
    /*
     新建
     */
    CalendarOperationStyleAdd = 1,
    /*
     查看
     */
    CalendarOperationStyleCat = 2,
    /*
     更改
     */
    CalendarOperationStyleUpdate = 3
};

@interface AddDiaryViewController : UIViewController

@end
