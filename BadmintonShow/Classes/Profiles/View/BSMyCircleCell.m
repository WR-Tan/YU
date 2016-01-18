//
//  BSMyCircleCell.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSMyCircleCell.h"
#import "BSCircleModel.h"

static NSInteger kQuitCircleButtonWidth = 60;

@interface BSMyCircleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *circleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (strong, nonatomic) UIButton *quitButton;
@property (assign, nonatomic) CGPoint prePoint;
@end

@implementation BSMyCircleCell

- (void)awakeFromNib {
    // Initialization code
    self.avatarView.layer.cornerRadius = 48/2.0f;
    self.avatarView.clipsToBounds = YES;
//    self.avatarView.layer.borderWidth = CGFloatPixelCeil(1);
//    self.avatarView.layer.borderColor = [UIColor blueColor].CGColor;
    
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
//    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(panGestureAction:)];
//    [self.contentView addGestureRecognizer:panGes];
//    
//    self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.quitButton.frame = CGRectMake(kScreenWidth - kQuitCircleButtonWidth, 0, kQuitCircleButtonWidth, 65);
//    self.quitButton.backgroundColor = [UIColor redColor];
//    [self.quitButton setTitle:@"退出" forState:UIControlStateNormal];
//    [self.quitButton addTarget:self action:@selector(quiteAction) forControlEvents:UIControlEventTouchUpOutside];
//    [self insertSubview:self.quitButton belowSubview:self.contentView];
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[BSCircleModel class]]) {
        BSCircleModel *circle = (BSCircleModel *)object;
        
        [self.avatarView setImageWithURL:circle.avatarUrl placeholder:UIImageNamed(@"iconfont-kequntoushi")];
        self.circleNameLabel.text = circle.name;
        self.descLabel.text = circle.desc;
        
    }
    
}

@end
