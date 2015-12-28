//
//  BSCircleResultCell.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleResultCell.h"

@interface BSCircleResultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *detailBgView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
@end

@implementation BSCircleResultCell

- (void)awakeFromNib {
    // Initialization code
    self.iconView.layer.cornerRadius = 60 / 2 ;
    self.iconView.clipsToBounds = YES;
    
    self.peopleCountLabel.layer.cornerRadius = 2;
    self.peopleCountLabel.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
