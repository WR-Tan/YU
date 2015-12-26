//
//  BSChooseSinglePlayerController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//  选择单打对手

#import "BSContactMainController.h"
#import "BSProfileUserModel.h"

@protocol BSChooseSinglePlayerControllerDelegate <NSObject>
- (void)selectedSinglePlayer:(BSProfileUserModel *)player;
@end

@interface BSChooseSinglePlayerController : BSContactMainController
@property (nonatomic, weak) id <BSChooseSinglePlayerControllerDelegate> delegate;
@end
