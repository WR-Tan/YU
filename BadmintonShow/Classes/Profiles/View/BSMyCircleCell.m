//
//  BSMyCircleCell.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSMyCircleCell.h"
#import "BSCircleModel.h"


@interface BSMyCircleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *circleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@end

@implementation BSMyCircleCell

- (void)awakeFromNib {
    // Initialization code
    self.avatarView.layer.cornerRadius = 48/2.0f;
    self.avatarView.clipsToBounds = YES;
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[BSCircleModel class]]) {
        BSCircleModel *circle = (BSCircleModel *)object;
        
        [self.avatarView setImageWithURL:circle.avatarUrl placeholder:kImageUserAvatar];
        self.circleNameLabel.text = circle.name;
        self.descLabel.text = circle.desc;
        
    }
    
}

@end
