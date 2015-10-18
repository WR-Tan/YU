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

@property (nonatomic, strong) BSMatchModel *match;
@property (nonatomic, strong) BSGameModel *game1;
@property (nonatomic, strong) BSGameModel *game2;
@property (nonatomic, strong) BSGameModel *game3;

@end


@implementation BSAddGameRecordCell{

    __weak IBOutlet UIView *secondGameView;
    __weak IBOutlet UIView *thirdGameView;
    
    __weak IBOutlet UITextField *firstGameA_scoreTF;
    __weak IBOutlet UITextField *firstGameB_scoreTF;
    __weak IBOutlet UITextField *secondGameA_scoreTF;
    __weak IBOutlet UITextField *secondGameB_scoreTF;
    __weak IBOutlet UITextField *thirdGameA_scoreTF;
    __weak IBOutlet UITextField *thirdGameB_scoreTF;
}

-(void)awakeFromNib{
    [super awakeFromNib];

    
    
}


-(void)setMatchType:(BSMatchType)matchType{
    _matchType = matchType;
    
    
    // 根据赛制做对应的调整。
}


#pragma mark - TF Delegate

/**
 *  利用pickerView应该比TextField自己去输入的好 —— 暂时不做
 */
-(void)textFieldDidEndEditing:(UITextField *)textField{

    
    if (textField == firstGameA_scoreTF) { // 第一局 A 分数
        self.game1.playerA_score = textField.text ;
    }
    
    if (textField == firstGameB_scoreTF) {  // 第一局 A 分数
        self.game1.playerB_score = textField.text ;
    }
    
    if (textField == firstGameB_scoreTF) {
        self.game1.playerB_score = textField.text ;
    }
    
    if (textField == firstGameB_scoreTF) {
        self.game1.playerB_score = textField.text ;
    }
    
    
    if (textField == firstGameB_scoreTF) {
        self.game1.playerB_score = textField.text ;
    }
    
    if (textField == firstGameB_scoreTF) {
        self.game1.playerB_score = textField.text ;
    }

}

//user001       5614663360b24927846400a9
//13410754258   5614663360b24927846400a9


#pragma mark - IBActions

- (IBAction)playerAAction:(id)sender {
    
}

- (IBAction)playerBAction:(id)sender {
    
}

- (IBAction)uploadAction:(id)sender {
    
    
}



#pragma mark - 懒加载

-(BSMatchModel *)match{
    if (!_match) {
        _match = [[BSMatchModel alloc] init];
    }
    return _match;
}

-(BSGameModel *)game1{
    if (!_game1) {
        _game1 = [[BSGameModel alloc] init];
    }
    return _game1;
}

-(BSGameModel *)game2{
    if (!_game2) {
        _game2 = [[BSGameModel alloc] init];
    }
    return _game2;
}

-(BSGameModel *)game3{
    if (!_game3) {
        _game3 = [[BSGameModel alloc] init];
    }
    return _game3;
}



@end









