//
//  BSMoreController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSMineController.h"
#import "BSProfileViewController.h"

@interface BSMineController ()
@property (nonatomic, strong) UIImageView *iconView;

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



@end
