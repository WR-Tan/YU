//
//  BSGameRecordDetailCell.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSGameRecordDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *playerAIcon;

@property (weak, nonatomic) IBOutlet UILabel *score;

@property (weak, nonatomic) IBOutlet UIImageView *playerBIcon;


@property (weak, nonatomic) IBOutlet UILabel *roundOneScore;
@property (weak, nonatomic) IBOutlet UILabel *roundTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *roundThreeScore;



@end
