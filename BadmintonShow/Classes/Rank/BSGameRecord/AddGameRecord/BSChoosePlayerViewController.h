//
//  BSChoosePlayerViewController.h
//  BadmintonShow
//
//  Created by LZH on 15/10/18.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "CDFriendListVC.h"

@protocol BSChoosePlayerViewControllerDelegate <NSObject>
- (void)didSelectPlayer:(AVUser *)user;
@end



@interface BSChoosePlayerViewController : CDFriendListVC
@property (nonatomic, weak) id <BSChoosePlayerViewControllerDelegate> delegate;
@end
