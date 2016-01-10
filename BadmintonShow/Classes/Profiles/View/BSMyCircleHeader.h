//
//  BSMyCircleHeader.h
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSMyCircleHeader;

@protocol BSMyCircleHeaderDelegate <NSObject>
- (void)circleHeader:(BSMyCircleHeader *)header didClickJionCircleAction:(UIButton *)jionButton;
- (void)circleHeader:(BSMyCircleHeader *)header didClickCreateCricleAction:(UIButton *)createButton;
@end

@interface BSMyCircleHeader : UIView
@property (nonatomic, weak) id<BSMyCircleHeaderDelegate> delegate ;
@end
