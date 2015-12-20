//
//  BSProfileEditViewController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/15/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseTableViewController.h"
@class BSProfileUserModel;

@protocol BSProfileEditViewControllerDelegate <NSObject>
- (void)updateUseInfo;
@end

@interface BSProfileEditViewController : BSBaseTableViewController
//@property (nonatomic, strong) BSProfileUserModel *userInfo ;
@property (nonatomic, weak) id <BSProfileEditViewControllerDelegate> delegate;
@end
