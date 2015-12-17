//
//  BSProfileCell.m
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileCell.h"
#import "BSProfileModel.h"


@implementation BSProfileCell{
    UIImageView *_imageView;
    UILabel *_title;
    UILabel *_detailLabel;
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
    _imageView = self.imageView;
    _title = self.textLabel;
    _detailLabel = self.detailTextLabel;
    _detailLabel.font = kDetailLabelFont;
//    //  头像
//    UIImageView *iconView = [UIImageView new];
//    [self.contentView addSubview:iconView];
//    _imageView = iconView;
//    
//    // 昵称
//    UILabel *nickNameLabel = [UILabel new];
//    nickNameLabel.font = kNickNameLabelFont;
//    [self.contentView addSubview:nickNameLabel];
//    _nickNameLabel = nickNameLabel;
//    
//    // 羽秀账号 (字母+数字)
//    UILabel *yuxiuPlaceHolder = [UILabel new];
//    yuxiuPlaceHolder.font = kYuxiuLabelFont;
//    yuxiuPlaceHolder.text = @"羽秀号:";
//    yuxiuPlaceHolder.textColor = kYuxiuLabelColor;
//    [self.contentView addSubview:yuxiuPlaceHolder];
//    
//    UILabel *yuxiuLabel = [UILabel new];
//    yuxiuLabel.font = kYuxiuLabelFont;
//    yuxiuLabel.textColor = kYuxiuLabelColor;
//    [self.contentView addSubview:yuxiuLabel];
//    _yuxiuLabel = yuxiuLabel;
//    
//    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(self.contentView).offset(kCellPadding);
//        make.width.equalTo(@(iconRadius));
//        make.height.equalTo(@(iconRadius));
//    }];
//    
//    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(iconView.mas_right).offset(kCellPadding);
//        make.top.equalTo(iconView).offset(kCellPadding);
//    }];
//    
//    [yuxiuPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(nickNameLabel);
//        make.top.equalTo(nickNameLabel.mas_bottom).offset(kCellPadding);
//    }];
//    
//    
//    [yuxiuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(yuxiuPlaceHolder);
//        make.left.equalTo(yuxiuPlaceHolder.mas_right).offset(kCellInnerPadding);
//    }];
    
}

- (void)displayWithItem:(id)object{
    if ([object isKindOfClass:[BSProfileModel class]]) {
        BSProfileModel *item = (BSProfileModel *)object;
        _title.text = item.title;
        _detailLabel.text = item.detail;
        _imageView.image = [UIImage imageNamed:item.imageName];
    }
}


@end
