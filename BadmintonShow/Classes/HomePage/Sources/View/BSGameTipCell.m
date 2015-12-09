//
//  BSGameTipCell.m
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameTipCell.h"
#import "Masonry.h"

@implementation BSGameTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        [self addMySubViews];
    }
    return self;
}


- (void)addMySubViews
{
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:24];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.equalTo(@(kScreenWidth - 60));
        make.height.equalTo(@(44));
    }];
}

@end
