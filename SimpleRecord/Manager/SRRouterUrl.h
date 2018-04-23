//
//  SRRouterUrl.h
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#ifndef SRRouterUrl_h
#define SRRouterUrl_h
//-----------------------注册登录-----------------------//
//登录
#define SR_LoginAndRegister_Login                   @"YD://simpleRecord/loginAndRegister/login"
//注册
#define SR_LoginAndRegister_Register(phone)         [NSString stringWithFormat:@"YD://simpleRecord/loginAndRegister/register/%@",phone]
//忘记密码
#define SR_LoginAndRegister_ForgotPassword(type,phone)   [NSString stringWithFormat:@"YD://simpleRecord/loginAndRegister/forgotPassword/%@/%@",type,phone]
//-----------------------日历-----------------------//
#define SR_Calendar               @"YD://simpleRecord/calendar"
#define SR_CalendarStyleTwo       @"YD://simpleRecord/calendarStyleTwo"
#define SR_Calendar_AddDiary(navTitle,style)      [NSString stringWithFormat:@"YD://simpleRecord/calendar/addDiary/%@/%@",navTitle,style]

//-----------------------记录-----------------------//
#define SR_Record                        @"YD://simpleRecord/record"
#define SR_RecordStyleTwo                @"YD://simpleRecord/recordStyleTwo"
#define SR_Record_AddRecord(type,id)        [NSString stringWithFormat:@"YD://simpleRecord/record/addRecord/%@/%@",type,id]

//-----------------------我的-----------------------//
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
