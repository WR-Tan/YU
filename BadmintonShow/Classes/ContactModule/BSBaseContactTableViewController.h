//
//  BSBaseContactTableViewController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSProfileUserModel;
extern NSString *const kCellIdentifier;

@interface BSBaseContactTableViewController : UITableViewController
- (void)configureCell:(UITableViewCell *)cell forUser:(BSProfileUserModel *)user;
@end



