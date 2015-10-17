//
//  BSProfileEditViewController.m
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSProfileEditViewController.h"
#import "MCPhotographyHelper.h"
#import "CDUtils.h"
#import "CDUserManager.h"
#import <LCUserFeedbackAgent.h>
#import "UserDefaultManager.h"

@interface BSProfileEditViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) MCPhotographyHelper *photographyHelper;
@end

@implementation BSProfileEditViewController
{


    __weak IBOutlet UIButton *_iconBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadDataSource];
    
    [self bodyInfo];
}


- (void)bodyInfo{
    AVObject *post = [AVObject objectWithClassName:@"BodyInfo"];
    post[@"name"] = @"每个 Objective-C 程序员必备的 8 个开发工具";
    post[@"pubUser"] = @"LeanCloud官方客服";
    post[@"pubTimestamp"] = @(1435541999);
    [post save];
}


#pragma mark - 懒加载


- (MCPhotographyHelper *)photographyHelper {
    if (_photographyHelper == nil) {
        _photographyHelper = [[MCPhotographyHelper alloc] init];
    }
    return _photographyHelper;
}


#pragma mark - IBAction
- (IBAction)iconAction:(id)sender {
    
    
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


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    if (buttonIndex == 0) {
        [self pickImage];
    } else {
        // 修改用户名，或者昵称
    }
}

-(void)pickImage {
    [self.photographyHelper showOnPickerViewControllerOnViewController:self completion:^(UIImage *image) {
        if (image) {
            UIImage *rounded = [CDUtils roundImage:image toSize:CGSizeMake(100, 100) radius:10];
            [[CDUserManager manager] updateAvatarWithImage : rounded callback : ^(BOOL succeeded, NSError *error) {
                if ([self filterError:error]) {
                    [self loadDataSource];
                }
            }];
        }
    }];
}


- (void)loadDataSource {
//    [self showProgress];
    [[CDUserManager manager] getBigAvatarImageOfUser:[AVUser currentUser] block:^(UIImage *image) {
        [[LCUserFeedbackAgent sharedInstance] countUnreadFeedbackThreadsWithBlock:^(NSInteger number, NSError *error) {
            
            [UserDefaultManager saveAvatarImage:image];
            
            [_iconBtn setImage:image forState:UIControlStateNormal];
            
            [self.tableView reloadData];
        }];
    }];
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
