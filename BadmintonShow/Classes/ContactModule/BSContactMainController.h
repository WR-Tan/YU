//
//  BSContactMainController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseContactTableViewController.h"
#import "BSContactResultsController.h"

@interface BSContactMainController : BSBaseContactTableViewController
@property (nonatomic, strong)  BSContactResultsController *resultsTableController;
@property (nonatomic, copy) NSArray *contactsArr;
@end
