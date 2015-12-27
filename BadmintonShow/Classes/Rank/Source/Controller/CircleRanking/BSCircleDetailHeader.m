//
//  BSCircleDetailHeader.m
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleDetailHeader.h"

@interface BSCircleDetailHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *circleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIImageView *creatorAvatarView;
@property (weak, nonatomic) IBOutlet UIImageView *adminOneAvatarView;
@property (weak, nonatomic) IBOutlet UIImageView *adminTwoAvatarView;

@property (weak, nonatomic) IBOutlet UIButton *peopleCountButton;

@end

@implementation BSCircleDetailHeader


- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSCircleDetailHeader" owner:nil options:nil] lastObject];
    self.creatorAvatarView.layer.cornerRadius = 48 / 2.0;
    self.creatorAvatarView.clipsToBounds = YES;
    
    self.adminOneAvatarView.layer.cornerRadius = 48 / 2.0;
    self.adminOneAvatarView.clipsToBounds = YES;
    
    self.adminTwoAvatarView.layer.cornerRadius = 48 / 2.0;
    self.adminTwoAvatarView.clipsToBounds = YES;
    
    return self;
}

- (IBAction)peopleCountAction:(id)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
