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

@property (weak, nonatomic) IBOutlet UIImageView *rankImageView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *jionTime;

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
        self.userNameLabel.text = userModel.userName;
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)userModel.score];
        
        //  是否隐藏
        self.rankImageView.hidden = indexPath.row < 3 ? NO : YES;
        self.rankLabel.hidden = indexPath.row < 3 ? YES : NO;
        
        NSString *imageName = (indexPath.row == 0) ? @"rank_first" :
                             ((indexPath.row == 1) ? @"rank_second" : @"rank_third");
        self.rankImageView.image = UIImageNamed(imageName);
        
//        NSString *genderIcon = [userModel.genderStr isEqualToString:@"F"] ? @"userinfo_icon_female" : @"userinfo_icon_male";
//        self.genderImageView.image = UIImageNamed(genderIcon);
        self.jionTime.text = nil;
    }
    
}

@end
