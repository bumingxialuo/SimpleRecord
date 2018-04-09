//
//  SRRouterUrl.h
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#ifndef SRRouterUrl_h
#define SRRouterUrl_h
//tab-> 日历
#define SR_Calendar               @"YD://simpleRecord/calendar"
#define SR_CalendarStyleTwo       @"YD://simpleRecord/calendarStyleTwo"
#define SR_Calendar_AddDiary      @"YD://simpleRecord/calendar/addDiary"

//tab-> 记录
#define SR_Record                 @"YD://simpleRecord/record"
#define SR_RecordStyleTwo         @"YD://simpleRecord/recordStyleTwo"

//tab-> 我的
#define SR_Mine                   @"YD://simpleRecord/mine"
//日记列表
#define SR_Mine_DiaryList         @"YD://simpleRecord/mine/diaryList"
//日记列表
#define SR_Mine_ArticleList       @"YD://simpleRecord/mine/articleList"
//功能配置
#define SR_Mine_FunctionConfig    @"YD://simpleRecord/mine/functionConfig"
//样式设置
#define SR_Mine_ChangeStyle       @"YD://simpleRecord/mine/changeStyle"
//帐号管理
#define SR_Mine_AccountManager    @"YD://simpleRecord/mine/accountManager"
//颜色选择
#define SR_Mine_ChangeStyle_ColorSlider(title)          [NSString stringWithFormat:@"YD://simpleRecord/mine/changeStyle/ColorSlider/%@",title]

#endif /* SRRouterUrl_h */
