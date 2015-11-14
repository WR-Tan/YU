//
//  BSAddGameRecordCell.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSAddGameRecordCell.h"

@interface BSAddGameRecordCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *playerA_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerB_nameLabel;

@property (nonatomic, strong) BSGameModel *game;

@end


@implementation BSAddGameRecordCell{
 
    __weak IBOutlet UITextField *firstGameA_scoreTF;
    __weak IBOutlet UITextField *firstGameB_scoreTF;
    NSString *_highScore;
    NSString *_lowScore;
    
}

#pragma mark - Public

-(void)setGameType:(BSGameType)gameType{
    self.game.gameType = gameType; // 比赛类型。
}


#pragma mark - Private

-(void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    
}

-(void)setSelected:(BOOL)selected{

    
}


#pragma mark - TF Delegate

/**
 *  利用pickerView应该比TextField自己去输入的好 —— 暂时不做
 */

- (void)handleScore{
    
    _highScore = firstGameA_scoreTF.text;
    _lowScore  = firstGameB_scoreTF.text;
    
    if ([_highScore integerValue] < [_lowScore integerValue]) {
        NSString *tempStr = _highScore;
        _highScore = _lowScore ;
        _lowScore = tempStr;
    }
    
    self.game.playerA_score = _highScore  ;
    self.game.playerB_score = _lowScore ;
}

#pragma mark - IBActions

- (IBAction)playerAAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentFriendListVC)]) {
        [self.delegate presentFriendListVC];
    }
}

- (IBAction)playerBAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentFriendListVC)]) {
        [self.delegate presentFriendListVC];
    }
}

- (IBAction)uploadAction:(id)sender {
    
    [self endEditing:YES];
    
    [self handleScore];
    
    if ([_highScore integerValue] > 30  || [_lowScore integerValue] < 0) {  // 最高是30分
        return;
    }
    
    [self initGame];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(uploadGame:button:)]) {
        [self.delegate uploadGame:self.game button:sender];
    }
}

- (void)initGame
{
    self.game.playerA_objectId = @"5614663360b24927846400a9";
    self.game.playerB_objectId = @"561496cb00b0866436724e9f";
    self.game.playerA_name = @"13410754258";
    self.game.playerB_name = @"user001";
}



#pragma mark - 懒加载

-(BSGameModel *)game{
    if (!_game) {
        _game = [[BSGameModel alloc] init];
    }
    return _game;
}



@end









