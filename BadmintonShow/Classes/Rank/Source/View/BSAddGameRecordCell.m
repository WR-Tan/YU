//
//  BSAddGameRecordCell.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSAddGameRecordCell.h"
#import "AVCloud.h"
#import "AVUser.h"

@interface BSAddGameRecordCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *playerA_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerB_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bImageView;

@property (assign, nonatomic) NSInteger aScore;
@property (assign, nonatomic) NSInteger bScore;


@end


@implementation BSAddGameRecordCell{
    

    NSString *_highScore;
    NSString *_lowScore;
    
}

#pragma mark - Public


#pragma mark - Private

-(void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(aTapGest:)];
    [_aImageView addGestureRecognizer:aTap];
    _aImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *bTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(bTapGest:)];
    [_bImageView addGestureRecognizer:bTap];
    _bImageView.userInteractionEnabled = YES;
}

-(void)setSelected:(BOOL)selected{
    
    
}

- (void)aTapGest:(id)sender {
    //  默认选中的就是自己咯
//    if (self.delegate && [self.delegate respondsToSelector:@selector(presentFriendListVC)]) {
//        [self.delegate presentFriendListVC];
//    }
}

- (void)bTapGest:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentFriendListVC)]) {
        [self.delegate presentFriendListVC];
    }
}

- (void)setGame:(BSGameModel *)game{
    _game = game;
    
    UIImage *aImage = game.aAVatar ? : [UIImage imageNamed:@"MaleDefault"];
    UIImage *bImage = game.bAVatar ? : [UIImage imageNamed:@"MaleDefault"];
    
    _aImageView.image = aImage;
    _bImageView.image = bImage;
    
    _playerA_nameLabel.text = game.playerA_name;
    _playerB_nameLabel.text = game.playerB_name;
}



#pragma mark - TF Delegate
#pragma mark - IBActions



- (IBAction)uploadAction:(id)sender {
    NSString *aScore = _firstGameA_scoreTF.text;
    NSString *bScore = _firstGameB_scoreTF.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(uploadGameWithAScore:bScore:button:)]) {
        [self.delegate uploadGameWithAScore:aScore bScore:bScore button:sender];
    }
}




@end









