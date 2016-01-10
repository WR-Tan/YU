//
//  BSSwitchCircleView.h
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//  点击圈子排名的title

#import <UIKit/UIKit.h>
#import "BSCircleModel.h"

@class BSSwitchCircleView;

@protocol BSSwitchCircleViewDelegate <NSObject>
- (void)switchView:(BSSwitchCircleView *)switchView didSelectCircle:(BSCircleModel *)circle;
@end

@interface BSSwitchCircleView : UIView
@property (nonatomic, weak) id <BSSwitchCircleViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dataArr; // 数据源
+ (BSSwitchCircleView *)switchView;
- (void)reloadDataWith:(NSArray *)dataArr;;
@end
