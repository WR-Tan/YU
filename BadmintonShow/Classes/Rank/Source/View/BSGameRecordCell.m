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
    self.playerAIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    self.playerBIcon.layer.cornerRadius = 48 / 2;
    self.playerBIcon.clipsToBounds = YES ;
    self.playerBIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    _winLabel.layer.cornerRadius = 20 / 2;
    _winLabel.highlighted = NO;
    _winLabel.clipsToBounds = YES;
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexPath{
    if (![object isKindOfClass:[BSGameModel class]]) return;
    
    BSGameModel *model = (BSGameModel *)object;
    [self.playerAIcon setImageWithURL:[NSURL URLWithString:model.aPlayer.avatarUrl] placeholder:kImageUserAvatar];
    [self.playerBIcon setImageWithURL:[NSURL URLWithString:model.bPlayer.avatarUrl] placeholder:kImageUserAvatar];
    
    self.aNameLabel.text = model.aPlayer.userName;
    self.bNameLabel.text = model.bPlayer.userName;
    
    self.score.text = [NSString stringWithFormat:@"%@ : %@",model.aScore,model.bScore];
    if (model.startTime.length == 19) {
        NSString *time = [model.startTime substringWithRange:NSMakeRange(5, 11)];
        self.creatAt.text = time;
    }
    
    BOOL isAWin = ([model.aScore integerValue] > [model.bScore integerValue]);
    self.winLabel.backgroundColor = isAWin ? [UIColor redColor] : [UIColor greenColor];
    self.winLabel.textColor = isAWin ? [UIColor whiteColor] : [UIColor blackColor];
    self.winLabel.text = isAWin ? @"胜" : @"败" ;
}

@end
