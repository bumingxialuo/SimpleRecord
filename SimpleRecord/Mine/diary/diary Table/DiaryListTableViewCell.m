//
//  DiaryListTableViewCell.m
//  SimpleRecord
//
//  Created by 不明下落 on 2018/4/16.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "DiaryListTableViewCell.h"
#import <Chameleon.h>
#import <Masonry.h>

@interface DiaryListTableViewCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *valueLable;
@property(nonatomic, strong) UIImageView *arrow;
@end

@implementation DiaryListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCellSubView];
    }
    return self;
}

- (void)updateWithTitle:(NSString *)title value:(NSString *)value isOpen:(BOOL)isOpen {
    _titleLabel.text = title;
    _valueLable.text = value;
    if (isOpen) {
        _arrow.image = [UIImage imageNamed:@"arrow on"];
    } else {
        _arrow.image = [UIImage imageNamed:@"arrow down"];
    }
}

- (void)createCellSubView {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"666"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _valueLable = [[UILabel alloc] init];
    _valueLable.font = [UIFont systemFontOfSize:14];
    _valueLable.textColor = [UIColor colorWithHexString:@"999"];
    _valueLable.textAlignment = NSTextAlignmentRight;
    _arrow = [[UIImageView alloc] init];
    _arrow.image = [UIImage imageNamed:@"arrow down"];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_valueLable];
    [self.contentView addSubview:_arrow];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [_valueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_arrow.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
