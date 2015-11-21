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

// 上传比赛
- (void)uploadGame:(BSGameModel *)game button:(UIButton *)btn;

// 上传
- (void)uploadGameWithAScore:(NSInteger)aScore bScore:(NSInteger)bScore  button:(UIButton *)btn;

//好友列表界面
- (void)presentFriendListVC;

@end

@interface BSAddGameRecordCell : UITableViewCell

@property (nonatomic, weak) id <BSAddGameRecordCellDelegate> delegate ;

- (void)setGameType:(BSGameType)gameType;

@end
