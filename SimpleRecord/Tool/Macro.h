//
//  Macro.h
//  SimpleRecord
//
//  Created by xia on 2018/3/12.
//  Copyright © 2018年 xia. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define HEIGHTOFSCREEN [[UIScreen mainScreen] bounds].size.height
#define WIDTHOFSCREEN [[UIScreen mainScreen] bounds].size.width
#define WIDTHRADIUS (WIDTHOFSCREEN/375.0)

#define IOSVERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define IOS7 (IOSVERSION >= 7.0)
#define IOS8 (IOSVERSION >= 8.0)
#define IOS9_2 (IOSVERSION >= 9.2)

#endif /* Macro_h */
