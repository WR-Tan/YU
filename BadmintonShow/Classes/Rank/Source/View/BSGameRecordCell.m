//
//  BSGameRecordself.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSGameRecordCell.h"
#import "BSGameModel.h"


@implementation BSGameRecordCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    self.playerAIcon.layer.cornerRadius = 48 / 2;
    self.playerAIcon.clipsToBounds = YES ;
    
    self.playerBIcon.layer.cornerRadius = 48 / 2;
    self.playerBIcon.clipsToBounds = YES ;
    
    _winLabel.layer.cornerRadius = 20 / 2;
    _winLabel.highlighted = NO;
    _winLabel.clipsToBounds = YES;
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexPath{
    if (![object isKindOfClass:[BSGameModel class]]) return;
    
    BSGameModel *model = (BSGameModel *)object;
    [self.playerAIcon setImageWithURL:[NSURL URLWithString:model.aPlayer.avatarUrl] placeholder:kUserAvatarImage];
    [self.playerBIcon setImageWithURL:[NSURL URLWithString:model.aPlayer.avatarUrl] placeholder:kUserAvatarImage];
    
    self.score.text = [NSString stringWithFormat:@"%@ : %@",model.aScore,model.bScore];
    self.creatAt.text = model.startTime;
    
    self.winLabel.backgroundColor = (indexPath.row == 0) ? [UIColor greenColor] : [UIColor redColor];
    self.winLabel.textColor = (indexPath.row == 0) ? [UIColor blackColor] : [UIColor whiteColor];
    
    self.winLabel.text = indexPath.row ? @"败" : @"胜";
}

@end
