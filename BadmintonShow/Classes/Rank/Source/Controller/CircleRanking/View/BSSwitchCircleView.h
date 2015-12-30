//
//  BSSwitchCircleView.h
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//  点击圈子排名的title

#import <UIKit/UIKit.h>
#import "BSCircelModel.h"

@class BSSwitchCircleView;

@protocol BSSwitchCircleViewDelegate <NSObject>
- (void)switchView:(BSSwitchCircleView *)switchView didSelectCircle:(BSCircelModel *)circle;
@end

@interface BSSwitchCircleView : UIView
@property (nonatomic, weak) id <BSSwitchCircleViewDelegate> delegate;
+ (BSSwitchCircleView *)switchView;
@end
