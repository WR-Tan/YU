//
//  BSConfirmGameCell.h
//  BadmintonShow
//
//  Created by LZH on 15/11/23.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSConfirmGameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *aAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *aNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *aScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bScoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UIImageView *confirmImageView;



@end
