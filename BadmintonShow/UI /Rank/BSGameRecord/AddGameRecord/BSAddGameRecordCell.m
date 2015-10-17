//
//  BSAddGameRecordCell.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSAddGameRecordCell.h"

@interface BSAddGameRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *playerA_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *playerB_nameLabel;


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

#pragma mark - original
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)playerAAction:(id)sender {
    
}

- (IBAction)playerBAction:(id)sender {
}




@end









