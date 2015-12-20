//
//  BSSelectCompanyController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/19/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseViewController.h"

@protocol BSSelectCompanyControllerDelegate <NSObject>
- (void)updateCompanyInfo;
@end

@interface BSSelectCompanyController : BSBaseViewController
@property (nonatomic, weak) id <BSSelectCompanyControllerDelegate> delegate;
@end
