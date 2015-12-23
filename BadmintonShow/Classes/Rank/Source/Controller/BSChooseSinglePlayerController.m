//
//  BSChooseSinglePlayerController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSChooseSinglePlayerController.h"

@interface BSChooseSinglePlayerController ()

@end

@implementation BSChooseSinglePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BSProfileUserModel *theUser = (tableView == self.tableView) ?
    self.contactsArr[indexPath.row] : self.resultsTableController.filteredProducts[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectedSinglePlayer:)]) {
        [self.delegate selectedSinglePlayer:theUser];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
