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


@end
