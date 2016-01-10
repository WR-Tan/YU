//
//  BSCircleResultCell.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleResultCell.h"
#import "BSCircleModel.h"

@interface BSCircleResultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *detailBgView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerCountLabel;

@end

@implementation BSCircleResultCell

- (void)awakeFromNib {
    // Initialization code
    self.iconView.layer.cornerRadius = 60 / 2 ;
    self.iconView.clipsToBounds = YES;
    
    self.playerCountLabel.layer.cornerRadius = 2;
    self.playerCountLabel.clipsToBounds = YES;
    
    self.playerCountLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(id)object {
    if ([object isKindOfClass:[BSCircleModel class]]) {
        BSCircleModel *circle = (BSCircleModel *)object;
        [self.iconView setImageWithURL:circle.avatarUrl  placeholder:kImageUserAvatar];
        self.nameLabel.text = circle.name;
        self.IDLabel.text = circle.circleId;
        self.descLabel.text = circle.desc;
        self.playerCountLabel.text = @"1999人";
    }
    
}


@end
