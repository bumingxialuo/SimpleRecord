//
//  StyleTypeTableViewCell.m
//  SimpleRecord
//
//  Created by xia on 2018/4/4.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "StyleTypeTableViewCell.h"
#import "Macro.h"
#import <Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import "UIImage+color.h"

@interface StyleTypeTableViewCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *valueImageView;
@property(nonatomic, strong) UILabel *valueLabel;
@end

@implementation StyleTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCellSubView];
    }
    return self;
}

- (void)updateWithTitleString:(NSString *)title ImageColor:(UIColor *)color {
    _valueLabel.hidden = YES;
    _valueImageView.hidden = NO;
    _titleLabel.text = title;
    _valueImageView.image = [UIImage createImageWithColor:color];
}


- (void)updateWithTitleString:(NSString *)title valueString:(NSString *)value {
    _valueLabel.hidden = NO;
    _valueImageView.hidden = YES;
    _titleLabel.text = title;
    _valueLabel.text = value;
}

- (void)createCellSubView {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"----";
    _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    _valueImageView = [[UIImageView alloc] init];
    _valueImageView.image = [UIImage createImageWithColor:[UIColor colorWithHexString:@"fff"]];
    [self.contentView addSubview:_valueImageView];
    
    _valueLabel = [[UILabel alloc] init];
    _valueLabel.text = @"----";
    _valueLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _valueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_valueLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(17);
    }];
    [_valueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-17);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-17);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
