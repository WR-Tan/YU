//
//  BSGameRecordCell.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSGameRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *playerAIcon;
@property (weak, nonatomic) IBOutlet UIImageView *playerBIcon;
@property (weak, nonatomic) IBOutlet UILabel *aNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *creatAt;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexPath;

@end
