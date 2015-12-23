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
#import "SVProgressHUD.h"

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
    _aImageView.clipsToBounds = YES;
    _aImageView.layer.cornerRadius =  36;
    _aImageView.contentMode = UIViewContentModeScaleAspectFill;
    _aImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapGest:)];
    [_aImageView addGestureRecognizer:aTap];
    
    _bImageView.clipsToBounds = YES;
    _bImageView.layer.cornerRadius =  36;
    _bImageView.userInteractionEnabled = YES;
    _bImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *bTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bTapGest:)];
    [_bImageView addGestureRecognizer:bTap];
 
    [_aImageView setImageWithURL:[NSURL URLWithString:AppContext.user.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
    if (!AppContext.user) {
        [SVProgressHUD showWithStatus:@"请先登录才能添加比赛"];
    }
    
    _playerB_nameLabel.text = @"请选择你的对手";
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
    
    [_aImageView setImageWithURL:[NSURL URLWithString:game.aPlayer.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
    [_bImageView setImageWithURL:[NSURL URLWithString:game.bPlayer.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
    _playerA_nameLabel.text = game.aPlayer.nickName;
    _playerB_nameLabel.text = game.bPlayer.nickName ? :@"请选择你的对手";
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









