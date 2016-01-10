//
//  CDNewFriendTableCell.m
//  LeanChat
//
//  Created by lzw on 14-10-23.
//  Copyright (c) 2014年 LeanCloud. All rights reserved.
//

#import "CDLabelButtonTableCell.h"

@implementation CDLabelButtonTableCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.leftImageView.clipsToBounds = YES;
    self.leftImageView.layer.cornerRadius = 48/ 2;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
