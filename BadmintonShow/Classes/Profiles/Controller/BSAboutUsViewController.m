//
//  BSAboutUsViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/23/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSAboutUsViewController.h"
#import "YYTextView.h"

@interface BSAboutUsViewController ()

@end

@implementation BSAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    YYTextView *txtView = [[YYTextView alloc] init];
    txtView.frame = CGRectMake(10, 10, kScreenWidth - 20, 200);
    
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
