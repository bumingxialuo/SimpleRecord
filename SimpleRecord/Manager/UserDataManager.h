//
//  UserDataManager.h
//  SimpleRecord
//
//  Created by xia on 2018/3/7.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)createDefaltDatabase;

- (void)loadUser;

//- (void)saveDiaryInfoWithArray:(NSArray *array)listArray;

@end
