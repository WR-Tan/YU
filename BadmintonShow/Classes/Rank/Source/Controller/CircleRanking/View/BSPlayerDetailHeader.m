//
//  BSPlayerDetailHeader.m
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSPlayerDetailHeader.h"
#import "Masonry.h"
#import "BSProfileUserModel.h"

@interface BSPlayerDetailHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *winRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolOrCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *shoolOrCompanyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIView *scoreSepLineLeft;
@property (weak, nonatomic) IBOutlet UIView *scoreSepLineRight;

@end

@implementation BSPlayerDetailHeader

- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSPlayerDetailHeader" owner:nil options:nil] lastObject];
    
    self.avatarImageView.layer.cornerRadius = 72/2.0f;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return self;
}


- (IBAction)makeFriendAction:(id)sender {
    
}


- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[BSProfileUserModel class]]) {
        BSProfileUserModel *user = (BSProfileUserModel *)object;
        [_avatarImageView setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholder:kImageUserAvatar];
        _userNameLabel.text = user.userName;
        _idLabel.text = user.yuxiuId ? [NSString stringWithFormat:@"ID: %@",user.yuxiuId]: @"" ;
        _gameCountLabel.text = [@(user.gameCount) stringValue];
        _scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)user.score ];
        _winRateLabel.text = [NSString stringWithFormat:@"%ld%%",(long)(user.winningPercentage *100)];
        
        NSString *occqupied = (user.company ? : user.school) ? : @"无";
        _shoolOrCompanyNameLabel.text = occqupied;
        _descLabel.text = user.desc?: @"无";
    }
}


@end
