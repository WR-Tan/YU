//
//  BSCircleAddMemberController.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/11.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSCircleAddMemberController.h"
#import "CDImageLabelTableCell.h"
#import "JSBadgeView.h"
#import "CDUserManager.h"
#import "CDIMService.h"
#import "BSCircleBusiness.h"

@interface BSCircleAddMemberController ()

@end

@implementation BSCircleAddMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加成员";
    self.navigationItem.rightBarButtonItem = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"", @""][section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDImageLabelTableCell *cell = [CDImageLabelTableCell createOrDequeueCellByTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    static NSInteger kBadgeViewTag = 103;
    JSBadgeView *badgeView = (JSBadgeView *)[cell viewWithTag:kBadgeViewTag];
    if (badgeView) {
        [badgeView removeFromSuperview];
    }
    
    AVUser *user = [self.dataSource objectAtIndex:indexPath.row];
    [[CDUserManager manager] displayAvatarOfUser:user avatarView:cell.myImageView];
    cell.myLabel.text = user.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AVUser *user = [self.dataSource objectAtIndex:indexPath.row];

    if ([self.delegate respondsToSelector:@selector(didSelectedUser:)]) {
        [self.delegate didSelectedUser:user];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"解除好友关系吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = indexPath.row;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        AVUser *user = [self.dataSource objectAtIndex:alertView.tag];
        [self showProgress];
        [[CDUserManager manager] removeFriend : user callback : ^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            if ([self filterError:error]) {
                [self refresh];
            }
        }];
    }
}

@end
