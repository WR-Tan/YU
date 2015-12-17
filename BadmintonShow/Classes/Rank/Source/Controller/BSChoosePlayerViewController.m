//
//  BSChoosePlayerViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/10/18.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSChoosePlayerViewController.h"

@implementation BSChoosePlayerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataSource.count) {
        AVUser *user = [self.dataSource objectAtIndex:indexPath.row];
        if (user && [self.delegate respondsToSelector:@selector(didSelectPlayer:)]) {
            [self.delegate didSelectPlayer:user];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
//    if (indexPath.section == 0) {
//        SEL selector = NSSelectorFromString(self.headerSectionDatas[indexPath.row][kCellSelectorKey]);
//        [self performSelector:selector withObject:nil afterDelay:0];
//    }
//    else {
//        AVUser *user = [self.dataSource objectAtIndex:indexPath.row];
//        [[CDIMService service] goWithUserId:user.objectId fromVC:self];
//    }
    
    
    
}


@end
