//
//  BSConfirmGameCell.m
//  BadmintonShow
//
//  Created by LZH on 15/11/23.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSConfirmGameCell.h"

@implementation BSConfirmGameCell{
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    self.aAvatarImageView.layer.cornerRadius = 36;
    self.aAvatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.aAvatarImageView.clipsToBounds = YES;
    self.bAvatarImageView.layer.cornerRadius = 36;
    self.bAvatarImageView.clipsToBounds = YES;
    self.bAvatarImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
