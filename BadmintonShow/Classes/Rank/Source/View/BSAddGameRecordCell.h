//
//  BSAddGameRecordCell.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGameModel.h"

@protocol BSAddGameRecordCellDelegate <NSObject>
- (void)uploadGame:(BSGameModel *)game button:(UIButton *)btn;
- (void)uploadGameWithAScore:(NSString *)aScoreStr bScore:(NSString *)bScoreStr  button:(UIButton *)btn;
- (void)presentFriendListVC;
@end

@interface BSAddGameRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *firstGameA_scoreTF;
@property (weak, nonatomic) IBOutlet UITextField *firstGameB_scoreTF;

@property (nonatomic, weak) id <BSAddGameRecordCellDelegate> delegate ;
@property (nonatomic, strong) BSGameModel * game ;
@end
