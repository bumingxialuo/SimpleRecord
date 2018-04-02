//
//  MineTableViewCell.m
//  SimpleRecord
//
//  Created by xia on 2018/4/2.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "MineTableViewCell.h"
#import <Masonry.h>
#import <Chameleon.h>
#import "AppSkinColorManger.h"

@interface MineTableViewCell()
@property(nonatomic, strong) UILabel *iconLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellSubView];
    }
    return self;
}

- (void)createCellSubView {
    _iconLabel = [[UILabel alloc] init];
    _iconLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    _iconLabel.textColor = [AppSkinColorManger sharedInstance].themeColor;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"----";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_iconLabel];
    [self.contentView addSubview:_titleLabel];
    [_iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(17);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_iconLabel.mas_right).offset(20);
    }];
}

- (void)updateWithIconImageName:(NSString *)icon TitleString:(NSString *)title {
    _iconLabel.text = icon;
    _titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
