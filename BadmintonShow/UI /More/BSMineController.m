//
//  BSMoreController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSMineController.h"
#import "BSProfileViewController.h"
#import "CDUserManager.h"
#import <LCUserFeedbackAgent.h>
#import "UserDefaultManager.h"
#import "BSProfileEditViewController.h"

@interface BSMineController ()<BSProfileEditViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@end

@implementation BSMineController{

    CGRect  _iconOldFrame ;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
        self.title = @"我";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *avatar = [UserDefaultManager avatar];
    [_iconBtn setImage:avatar forState:UIControlStateNormal] ;
    
    [self loadIcon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)iconAction:(id)sender {
    
    //  浏览图片
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 3 && indexPath.row == 0) {
        [self pushProfileVC];
    }
}

- (void)pushProfileVC
{
    BSProfileViewController *profileVC = [[BSProfileViewController alloc] init];
    [self.navigationController pushViewController:profileVC animated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier  isEqualToString:@"BSProfileEditViewControllerSegue"]) {
        
        BSProfileEditViewController *profileEditVC = (BSProfileEditViewController *)segue.destinationViewController ;
        profileEditVC.delegate = self;
    };

}

- (void)changeIcon:(UIImage *)image{
    [_iconBtn setImage:image forState:UIControlStateNormal];
}


- (void)loadIcon {

    [[CDUserManager manager] getBigAvatarImageOfUser:[AVUser currentUser] block:^(UIImage *image) {
        [[LCUserFeedbackAgent sharedInstance] countUnreadFeedbackThreadsWithBlock:^(NSInteger number, NSError *error) {

            [_iconBtn setImage:image forState:UIControlStateNormal];
            
            [UserDefaultManager saveAvatarImage:image];
            
            [self.tableView reloadData];
        }];
    }];
}







@end
