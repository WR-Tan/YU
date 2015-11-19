//
//  BSChatMatchView.h
//  BadmintonShow
//
//  Created by LZH on 15/11/20.
//  Copyright © 2015年 LZH. All rights reserved.
//  聊天界面-Cell-发送比赛，接受比赛的View

#import <UIKit/UIKit.h>

@class BSGameModel;


@interface BSChatMatchView : UIControl

@property (nonatomic, strong) BSGameModel *game ;

@end
