//
//  BSRankHeader.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSRankHeader.h"
#define kBSViewBorder 10

@implementation BSRankHeader

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
    _icon.layer.borderColor = (__bridge CGColorRef)([UIColor purpleColor]);
    _icon.layer.borderWidth = 2;
    
    
    CGFloat nameWidth  =  120;
    CGFloat nameHeight =  20;
    CGFloat nameX = kBSViewBorder;
    CGFloat nameY = CGRectGetMaxY(_icon.frame) + kBSViewBorder;
    _name.frame = CGRectMake( nameX, nameY,nameWidth, nameHeight);
    _name.text = @"昵称：李智华";
    
    CGFloat rankWidth  =  120;
    CGFloat rankHeight =  20;
    CGFloat rankX = kBSViewBorder;
    CGFloat rankY = CGRectGetMaxY(_name.frame) + kBSViewBorder;
    _ranking.frame = CGRectMake(rankX, rankY, rankWidth, rankHeight);
    _ranking.text = @"排名：第100名";
    
    CGFloat introduceWidth  = kScreenWidth - kBSViewBorder * 2;
    CGFloat introduceHeight =  20;
    CGFloat introduceX =  kBSViewBorder;
    CGFloat introduceY =  CGRectGetMaxY(_ranking.frame) + kBSViewBorder;
    _introduce.frame = CGRectMake(introduceX, introduceY, introduceWidth, introduceHeight);
    _introduce.text = @"简介：直到世界尽头";
   
}

- (void)addViews{

    //  头像
    _icon = [[UIImageView alloc] init];
    _icon.backgroundColor = [UIColor yellowColor];
    [self addSubview:_icon];
    
    //  名称
    _name= [[UILabel alloc ] init];
    [self addSubview:_name];
    
    //  排名
    _ranking= [[UILabel alloc ] init];
    [self addSubview:_ranking];
    
    
    //  简介
    _introduce = [[UILabel alloc ] init];
    [self addSubview:_introduce];

   



}



@end
