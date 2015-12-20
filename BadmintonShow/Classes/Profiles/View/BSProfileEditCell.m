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
    NSString *_imageUrl;
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
    self.detailTextLabel.font = kDetailLabelFontLarge;
    
    _detailImageView = [UIImageView new];
    _detailImageView.layer.cornerRadius = kBSAvatarRadius ;
    _detailImageView.clipsToBounds = YES;
    _detailImageView.size = CGSizeMake(iconWidth, iconWidth);
    _detailImageView.userInteractionEnabled = YES ;
    _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _detailImageView.center = CGPointMake(kScreenWidth - iconWidth, kCellHeight / 2);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayImage)];
    
    [_detailImageView addGestureRecognizer:tap];
    [self.contentView addSubview:_detailImageView];
}

- (void)displayImage {
    if ([self.delegate respondsToSelector:@selector(cell:imageView:displayImageUrl:)]) {
        [_delegate cell:self imageView:_detailImageView  displayImageUrl:_imageUrl];
    }
}

- (void)displayWithItem:(id)object{
    
    if ([object isKindOfClass:[BSProfileModel class]]) {
        BSProfileModel *item = (BSProfileModel *)object;
        self.textLabel.text = item.title;
        self.detailTextLabel.text = item.detail;
        
        if ([item.title isEqualToString:@"性别"]) {
            if ([item.detail isEqualToString:@"M"]) self.detailTextLabel.text = @"男";
            if ([item.detail isEqualToString:@"F"]) self.detailTextLabel.text = @"女";
            if ([item.detail isEqualToString:@"U"]) self.detailTextLabel.text = @"保密";
        }
        
        
        if (item.thumbnailUrl) {
            _imageUrl = item.thumbnailUrl;
            _detailImageView.hidden = NO;
            [_detailImageView setImageWithURL:[NSURL URLWithString:item.thumbnailUrl] placeholder:nil];
        } else {
            _detailImageView.hidden = YES;
        }
        
        self.accessoryType = [item.title isEqualToString:@"羽秀号"] ?
        UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
        

    }
}

@end
