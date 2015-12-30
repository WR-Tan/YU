//
//  BSPlayerDetailHeader.m
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSPlayerDetailHeader.h"
#import "Masonry.h"

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
    
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    CGFloat leftX = (kScreenWidth - 1) / 3;
//    CGFloat rightX = ((kScreenWidth - 1) / 3 )* 2;
//    self.scoreSepLineLeft.frame = CGRectMake(leftX, 10, 0.5, 50 - 20);
//    self.scoreSepLineRight.frame = CGRectMake(rightX, 10, 0.5, 50 - 20);
}

- (IBAction)makeFriendAction:(id)sender {
    
}



@end
