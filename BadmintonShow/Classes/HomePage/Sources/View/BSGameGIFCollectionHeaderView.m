//
//  BSGameGifCollectionHeaderView.m
//  BadmintonShow
//
//  Created by LZH on 15/12/6.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameGIFCollectionHeaderView.h"
#import "Masonry.h"

@implementation BSGameGIFCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addMyViews];
    }
    return self ;
}


- (void)addMyViews
{
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

@end
