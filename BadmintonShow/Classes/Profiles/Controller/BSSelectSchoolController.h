//
//  BSSelectSchoolController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/19/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseViewController.h"

@protocol BSSelectSchoolControllerDelegate <NSObject>
- (void)updateSchoolInfo;
@end

@interface BSSelectSchoolController : BSBaseViewController
@property (nonatomic, weak) id <BSSelectSchoolControllerDelegate> delegate;
@end
