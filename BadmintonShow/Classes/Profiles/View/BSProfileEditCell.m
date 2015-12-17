//
//  BSProfileEditCell.m
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileEditCell.h"
#import "BSProfileModel.h"
#import "Masonry.h"
#import "YYKit.h"

#define iconWidth 72
#define kNickNameLabelFont [UIFont systemFontOfSize:18]
#define kYuxiuLabelFont [UIFont systemFontOfSize:14]
#define kYuxiuLabelColor [UIColor grayColor]
#define kCellPadding 10
#define kCellInnerPadding 5
#define kCellHeight 90

@implementation BSProfileEditCell{
    UILabel *_nickNameLabel;
    UILabel *_yuxiuLabel;
    UIImageView *_detailImageView ;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self constructSubViews];
    }
    return self;
}

- (void)constructSubViews{
    self.contentView.backgroundColor = [UIColor whiteColor];

    _detailImageView = [UIImageView new];
    _detailImageView.layer.cornerRadius = kBSAvatarRadius ;
    _detailImageView.clipsToBounds = YES;
    _detailImageView.size = CGSizeMake(iconWidth, iconWidth);
    _detailImageView.center = CGPointMake(kScreenWidth - iconWidth, kCellHeight / 2);
    [self.contentView addSubview:_detailImageView];
    
    self.detailTextLabel.font = kDetailLabelFont;
}

- (void)displayWithItem:(id)object{
    
    if ([object isKindOfClass:[BSProfileModel class]]) {
        BSProfileModel *item = (BSProfileModel *)object;
        self.textLabel.text = item.title;
        self.detailTextLabel.text = item.detail;
        if (item.thumbnailUrl) {
            _detailImageView.hidden = NO;
            [_detailImageView setImageWithURL:[NSURL URLWithString:item.thumbnailUrl] placeholder:nil];
        } else {
            _detailImageView.hidden = YES;
        }
    }
}

@end
