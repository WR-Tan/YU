//
//  BSProfileEditViewController.m
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSProfileEditViewController.h"

@interface BSProfileEditViewController ()<UIActionSheetDelegate>

@end

@implementation BSProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 || indexPath.row == 0) {
        [self showEditActionSheet:nil];
    }
}


- (void)showEditActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更新资料" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"更改头像", @"更改用户名", nil];
    [actionSheet showInView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
