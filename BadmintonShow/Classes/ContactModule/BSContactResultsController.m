//
//  BSContactResultsController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSContactResultsController.h"
#import "BSProfileUserModel.h"

@interface BSContactResultsController ()

@end

@implementation BSContactResultsController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    BSProfileUserModel *user = self.filteredProducts[indexPath.row];
    [self configureCell:cell forUser:user];
    
    return cell;
}


@end
