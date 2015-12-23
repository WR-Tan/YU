//
//  BSSkyLadderTableViewCell.m
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSkyLadderTableViewCell.h"
#import "BSProfileUserModel.h"

@interface BSSkyLadderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation BSSkyLadderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.iconView.layer.cornerRadius = 36 / 2;
    self.iconView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexPath{
    if ([object isKindOfClass:[BSProfileUserModel class]]) {
        BSProfileUserModel *userModel = (BSProfileUserModel *)object;
        self.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        [self.iconView setImageWithURL:[NSURL URLWithString:userModel.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
        self.userNameLabel.text = userModel.nickName;
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)userModel.score];
    }
    
}

@end
