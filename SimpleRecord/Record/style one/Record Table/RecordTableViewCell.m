//
//  RecordTableViewCell.m
//  SimpleRecord
//
//  Created by xia on 2018/3/12.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "RecordTableViewCell.h"
#import <Masonry/Masonry.h>
#import "AppSkinColorManger.h"
#import "Macro.h"
#import <ChameleonFramework/Chameleon.h>

@implementation RecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [AppSkinColorManger sharedInstance].backgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCellSubView];
    }
    return self;
}

- (void)createCellSubView {
    UIView *cellContain = [[UIView alloc] initWithFrame:CGRectMake(20*WIDTHRADIUS, 15, WIDTHOFSCREEN - 40*WIDTHRADIUS, 170)];
    [self addSubview:cellContain];
    cellContain.layer.masksToBounds = YES;
    cellContain.layer.cornerRadius = 20.0;
//    cellContain.layer.borderWidth = 2.0;
//    cellContain.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    cellContain.backgroundColor = [AppSkinColorManger sharedInstance].secondColor;
    [cellContain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 18*WIDTHRADIUS, 20, 18*WIDTHRADIUS));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
