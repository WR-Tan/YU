//
//  BSBaseContactTableViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseContactTableViewController.h"
#import "BSProfileUserModel.h"

NSString *const kCellIdentifier = @"ContactCellID";
NSString *const kTableCellNibName = @"BSContactTableViewCell";

@implementation BSBaseContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forUser:(BSProfileUserModel *)user {
    [cell.imageView setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
    cell.textLabel.text = user.nickName;
    cell.detailTextLabel.text = user.userName;
}


@end
