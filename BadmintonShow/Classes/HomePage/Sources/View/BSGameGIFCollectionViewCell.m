
//
//  BSGameGIFCollectionViewCell.m
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameGIFCollectionViewCell.h"
#import "Masonry.h"

@implementation BSGameGIFCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addMyViews];
    }
    return self ;
}


- (void)addMyViews
{

//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
//    self.imageView = imgView ;
//    [self addSubview:imgView];

    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:self.frame];
    gifImageView.backgroundColor = [UIColor blueColor];
    self.imageView = gifImageView ;
    [self.contentView addSubview:gifImageView];
}



@end
