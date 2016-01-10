//
//  BSRankHeader.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSRankHeader.h"
#define kBSViewBorder 10
#define kBSViewInnerBorder 8

@implementation BSRankHeader{
    UILabel *_nickNamePlaceholder;
    UILabel *_rankPlaceholder;
    UILabel *_introducePlaceholder;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self addViews];
    }
    return self;
}


-(void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    CGFloat iconWidth  =  100;
    CGFloat iconHeight = iconWidth;
    CGFloat iconX = kScreenWidth/2;
    CGFloat iconY = 60;
    _icon.bounds = CGRectMake(0, 0, iconWidth, iconHeight);
    _icon.center = CGPointMake(iconX, iconY);
    _icon.layer.cornerRadius = iconWidth / 2;
    _icon.clipsToBounds = YES ;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon.layer.borderColor = (__bridge CGColorRef)([UIColor purpleColor]);
    _icon.layer.borderWidth = 2;
    [_icon setImageWithURL:[NSURL URLWithString:AppContext.user.avatarUrl] placeholder:kImageUserAvatar];
    
    CGFloat labelWidth = 220 ;
    CGFloat placeholderWidth = 35 ;
    CGFloat labelHeight = 20;
    
    _nickNamePlaceholder.left = kBSViewBorder;
    _nickNamePlaceholder.top = CGRectGetMaxY(_icon.frame) + kBSViewInnerBorder;
    _nickNamePlaceholder.width = placeholderWidth ;
    _nickNamePlaceholder.height = labelHeight ;
    _nickNamePlaceholder.text = @"名称:";
    
    CGFloat nameWidth  =  labelWidth;
    CGFloat nameHeight =  labelHeight;
    CGFloat nameX = _nickNamePlaceholder.right + kBSViewBorder;
    CGFloat nameY = _nickNamePlaceholder.top;
    _name.frame = CGRectMake( nameX, nameY,nameWidth, nameHeight);
    _name.text = AppContext.user.nickName;
    
    
    _rankPlaceholder.left = kBSViewBorder;
    _rankPlaceholder.top = _nickNamePlaceholder.bottom + kBSViewInnerBorder;
    _rankPlaceholder.width = 50;
    _rankPlaceholder.height = labelHeight;
    _rankPlaceholder.text = @"天梯分:";
    
    CGFloat rankWidth  =  labelWidth;
    CGFloat rankHeight =  labelHeight;
    CGFloat rankX = _rankPlaceholder.right + kBSViewBorder;
    CGFloat rankY = _rankPlaceholder.top;
    _ranking.frame = CGRectMake(rankX, rankY, rankWidth, rankHeight);
    
    
    _introducePlaceholder.left = kBSViewBorder;
    _introducePlaceholder.top = _rankPlaceholder.bottom + kBSViewInnerBorder + 10 ;
    _introducePlaceholder.width = placeholderWidth;
    _introducePlaceholder.height = labelHeight;
    _introducePlaceholder.text = @"签名:";
    
    CGFloat introduceWidth  = labelWidth ;
    CGFloat introduceHeight =  40;
    CGFloat introduceX =  _introducePlaceholder.right + kBSViewBorder;
    CGFloat introduceY =  _rankPlaceholder.bottom + kBSViewInnerBorder;
    _introduce.frame = CGRectMake(introduceX, introduceY, kScreenWidth - introduceX - 10, introduceHeight);
}

- (void)addViews{

    //  头像
    _icon = [[UIImageView alloc] init];
    
    [self addSubview:_icon];
    
    _nickNamePlaceholder = [UILabel new];
    _nickNamePlaceholder.textColor = [UIColor darkGrayColor];
    _name= [[UILabel alloc ] init];
    [self addSubview:_nickNamePlaceholder];
    [self addSubview:_name];
    
    //  排名
    _rankPlaceholder = [UILabel new];
    _rankPlaceholder.textColor = [UIColor darkGrayColor];
    _ranking= [[UILabel alloc ] init];
    [self addSubview:_rankPlaceholder];
    [self addSubview:_ranking];
    
    _introducePlaceholder = [UILabel new];
    _introducePlaceholder.textColor = [UIColor darkGrayColor];
    _introduce = [[UILabel alloc ] init];
    _introduce.numberOfLines = 2;
    [self addSubview:_introducePlaceholder];
    [self addSubview:_introduce];
    
    for (UILabel *label in self.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
        label.font = kBSFontSize(15);
        }
    }
}



#pragma mark - UesrMessage





@end
