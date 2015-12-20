//
//  BSSelectGenderController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/19/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol BSSelectGenderControllerDelegate <NSObject>
- (void)updateUserGender;
@end

@interface BSSelectGenderController : BaseTableViewController
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, weak) id <BSSelectGenderControllerDelegate> delegate;
@end
