//
//  BSCircleAddMemberController.h
//  BadmintonShow
//
//  Created by lizhihua on 16/1/11.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "CDFriendListVC.h"

@protocol BSCircleAddMemberControllerDelegate <NSObject>
- (void)didSelectedUser:(AVUser *)user;
@end

@interface BSCircleAddMemberController : CDFriendListVC
@property (nonatomic, weak) id <BSCircleAddMemberControllerDelegate> delegate;
@end

