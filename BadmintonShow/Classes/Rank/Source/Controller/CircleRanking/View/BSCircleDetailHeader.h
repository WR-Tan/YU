//
//  BSCircleDetailHeader.h
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSProfileUserModel;
@class BSCircleDetailHeader;

@protocol BSCircleDetailHeaderDelegate <NSObject>
- (void)circleDetailHeader:(BSCircleDetailHeader *)header didClickCircleAvatar:(UIImageView *)avatarView;
- (void)circleDetailHeader:(BSCircleDetailHeader *)header didClickCreator:(BSProfileUserModel *)creator;
- (void)didClickPeopleCountButton;

@end

@interface BSCircleDetailHeader : UIView
@property (nonatomic, weak) id <BSCircleDetailHeaderDelegate> delegate;
- (void)setObject:(id)object;

@end
