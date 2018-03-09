//
//  SRRouterManager.h
//  SimpleRecord
//
//  Created by xia on 2018/3/9.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HHRouter/HHRouter.h>
#import "SRRouterUrl.h"

@interface SRRouterManager : NSObject

+ (SRRouterManager *)shardInstance;

- (void)createAllRouterController;

@end
