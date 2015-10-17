//
//  BSProfileEditViewController.h
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSBaseTableViewController.h"

@protocol BSProfileEditViewControllerDelegate <NSObject>

- (void)changeIcon:(UIImage *)image;

@end

@interface BSProfileEditViewController : BSBaseTableViewController

@property (nonatomic , weak) id <BSProfileEditViewControllerDelegate> delegate ;

@end
