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
@property (nonatomic, strong) AVObject *userInfo ;


@end

@implementation BSProfileEditViewController
{

        __weak IBOutlet UIButton *_iconBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadDataSource];
    
    [self querryUserInfo ];
}



- (void)querryUserInfo
{
    AVQuery *query = [AVQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userObjectId" equalTo:[AVUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"Successfully retrieved %lu posts.", (unsigned long)objects.count);
            AVObject *userInfo = [objects lastObject];
            NSLog(@"address = %@",userInfo[@"address"]);
            
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


/**
 *  创建UserInfo这个类，存放选手/玩家信息
 */
- (void)setUserInfo{
    AVObject *post = [AVObject objectWithClassName:@"UserInfo"];
    post[@"userObjectId"] =  [AVUser currentUser].objectId;
    post[@"name"] = @"神";
    post[@"nickName"] = @"宙斯";
    post[@"sex"] = @"female";
    post[@"height"] =  @1.9;
    post[@"weight"] =  @140;
    post[@"birthday"] =  @"19901006";
    post[@"city"] =  @"深圳";
    post[@"address"] =  @"白石洲";
    [post save];
}


#pragma mark - 懒加载

-(AVObject *)userInfo{
    if (_userInfo == nil) {
         _userInfo = [AVObject objectWithClassName:@"UserInfo"];
    }
    return  _userInfo;
}

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
