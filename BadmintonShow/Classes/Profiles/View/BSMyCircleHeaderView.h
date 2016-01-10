//
//  BSMyCircleHeaderView.h
//  BadmintonShow
//
//  Created by lizhihua on 16/1/9.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSMyCircleHeaderView : UIView

@property (nonatomic, copy) NSString *title ;

+ (BSMyCircleHeaderView *)sectionHeader;
+ (CGFloat)height;

@end
