//
//  MineTableHeadView.h
//  SimpleRecord
//
//  Created by xia on 2018/3/30.
//  Copyright © 2018年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineTableHeadViewdelegate<NSObject>
- (void)mineTableHeadViewDoLogin;
@end

@interface MineTableHeadView : UIView
@property(nonatomic, weak) id<MineTableHeadViewdelegate> headViewDelegate;
@end
