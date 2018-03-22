//
//  RecordStyleTwoTableVIew.m
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordStyleTwoTableView.h"
#import "AppSkinColorManger.h"
#import <ChameleonFramework/UIColor+Chameleon.h>
#import "RecordStyleTwoTableViewCell.h"

#define kCloseCellHeight    179.f
#define kOpenCellHeight     488.f
#define kRowsCount          10

#define RecordStyleTwoTableViewCellId @"RecordStyleTwoTableViewCellId"

@interface RecordStyleTwoTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;

@end

@implementation RecordStyleTwoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"StyleTwoCell" bundle:nil] forCellReuseIdentifier:RecordStyleTwoTableViewCellId];
        self.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight
                                                     withFrame:self.frame
                                                     andColors:@[[AppSkinColorManger sharedInstance].themeColor,
                                                                 [AppSkinColorManger sharedInstance].secondColor]];
        [self createCellHeightsArray];
    }
    return self;
}

- (void)createCellHeightsArray
{
    for (int i = 0; i < kRowsCount; i ++) {
        [self.cellHeights addObject:@(kCloseCellHeight)];
    }
}

#pragma mark - UITableViewDelegate And UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordStyleTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordStyleTwoTableViewCellId];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeights[indexPath.row].floatValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordStyleTwoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isKindOfClass:[RecordStyleTwoTableViewCell class]]) return;
    
    if (cell.isAnimating) return;
    
    NSTimeInterval duration = 0.f;
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    
    if (cellHeight == kCloseCellHeight) {
        self.cellHeights[indexPath.row] = @(kOpenCellHeight);
        [cell selectedAnimationByIsSelected:YES animated:YES completion:nil];
        duration = 1.f;
    }else
    {
        self.cellHeights[indexPath.row] = @(kCloseCellHeight);
        [cell selectedAnimationByIsSelected:NO animated:YES completion:nil];
        duration = 1.f;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RecordStyleTwoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![cell isKindOfClass:[RecordStyleTwoTableViewCell class]]) return;
    
    cell.backgroundColor = [UIColor clearColor];
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    if (cellHeight == kCloseCellHeight) {
        [cell selectedAnimationByIsSelected:NO animated:NO completion:nil];
    }else
    {
        [cell selectedAnimationByIsSelected:YES animated:NO completion:nil];
    }
    
//    [cell setNumber:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kRowsCount;
}

#pragma mark - Getter && Setter

- (NSMutableArray<NSNumber *> *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _cellHeights;
}


@end
