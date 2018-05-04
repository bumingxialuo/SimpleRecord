//
//  TableDataSource.m
//  SimpleRecord
//
//  Created by xia on 2018/5/3.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "TableDataSource.h"
#import "AppSkinColorManger.h"

@implementation TableDataSource

- (NSMutableArray *)createTableViewSectionOneDataSource{
    NSMutableArray *targetArray = [NSMutableArray new];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic1 setObject:@"主题色" forKey:@"title"];
    [dic1 setObject:[AppSkinColorManger sharedInstance].themeColor forKey:@"fill"];
    [dic1 setObject:@"" forKey:@"desc"];
    [dic1 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic2 setObject:@"第一辅色" forKey:@"title"];
    [dic2 setObject:[AppSkinColorManger sharedInstance].secondColor forKey:@"fill"];
    [dic2 setObject:@"" forKey:@"desc"];
    [dic2 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic3 setObject:@"第二辅色" forKey:@"title"];
    [dic3 setObject:[AppSkinColorManger sharedInstance].thirdColor forKey:@"fill"];
    [dic3 setObject:@"" forKey:@"desc"];
    [dic3 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic4 setObject:@"背景色" forKey:@"title"];
    [dic4 setObject:[AppSkinColorManger sharedInstance].backgroundColor forKey:@"fill"];
    [dic4 setObject:@"" forKey:@"desc"];
    [dic4 setObject:@(YES) forKey:@"click"];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic5 setObject:@"动画色" forKey:@"title"];
    [dic5 setObject:[AppSkinColorManger sharedInstance].animationOneColor forKey:@"fill"];
    [dic5 setObject:@"" forKey:@"desc"];
    [dic5 setObject:@(YES) forKey:@"click"];
    
    [targetArray addObject:dic1];
    [targetArray addObject:dic2];
    [targetArray addObject:dic3];
    [targetArray addObject:dic4];
    [targetArray addObject:dic5];
    
    return targetArray;
}

- (NSMutableArray *)createTableViewSectionTwoDataSource {
    NSMutableArray *targetArray = [NSMutableArray new];
    NSDictionary *dic11 = @{@"title":@"文章开关",@"fill":@"开启",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic12 = @{@"title":@"文章方案",@"fill":@"方案一",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic13 = @{@"title":@"日记开关",@"fill":@"开启",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic14 = @{@"title":@"日记方案",@"fill":@"方案二",@"desc":@"",@"click":@(YES)};
    NSDictionary *dic15 = @{@"title":@"我的方案",@"fill":@"列表方案",@"desc":@"",@"click":@(YES)};
    
    [targetArray addObject:dic11];
    [targetArray addObject:dic12];
    [targetArray addObject:dic13];
    [targetArray addObject:dic14];
    [targetArray addObject:dic15];
    return targetArray;
}

@end
