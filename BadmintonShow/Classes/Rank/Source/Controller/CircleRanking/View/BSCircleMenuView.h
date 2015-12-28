//
//  BSCircleMenuView.h
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSCircleMenuView;

@protocol BSCircleMenuViewDelegate <NSObject>
- (void)menu:(BSCircleMenuView *)menu didClickIndex:(NSUInteger)index;
@end

@interface BSCircleMenuView : UIView
@property (nonatomic, weak) id <BSCircleMenuViewDelegate> delegate;
+ (BSCircleMenuView *)menuView;
@end
