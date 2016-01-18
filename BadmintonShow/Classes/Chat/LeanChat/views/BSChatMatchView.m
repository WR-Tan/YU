//
//  BSChatMatchView.m
//  BadmintonShow
//
//  Created by LZH on 15/11/20.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSChatMatchView.h"

@interface BSChatMatchView()

@property (nonatomic, strong) UILabel *messageLabel;

@end


@implementation BSChatMatchView


+ (instancetype)matchView {
    BSChatMatchView *matchView = [[BSChatMatchView alloc] init];
    matchView.frame = CGRectMake(0, 0, 170, 80);
    
    UIColor *borderColor = UIColorHex(F0F0F0);
    matchView.layer.borderColor = borderColor.CGColor;
    matchView.layer.borderWidth = CGFloatPixelCeil(0.5);
    
    matchView.layer.cornerRadius = 4;
    matchView.clipsToBounds = YES;

    return matchView;
}


- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSChatMatchView" owner:nil options:nil] lastObject];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addMyViews];
    }
    return self;
}

- (void)addMyViews
{
    _messageLabel = [[UILabel alloc]  init];
    _messageLabel.text = @"您有新的比赛结果等待确认";
    [self addSubview:_messageLabel];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];

    [_messageLabel sizeToFit];
    _messageLabel.font = [UIFont systemFontOfSize:15];
    CGSize labelSize = _messageLabel.frame.size;
    _messageLabel.frame = CGRectMake(5, 40, labelSize.width, labelSize.height);
}


@end
