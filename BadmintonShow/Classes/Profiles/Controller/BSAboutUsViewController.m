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
    self.tableView.backgroundColor = [UIColor whiteColor];
 
#warning 这里应该加一个AppIcon
    
    YYTextView *txtView = [[YYTextView alloc] init];
    txtView.frame = CGRectMake(10, 20, kScreenWidth - 20, 400);
    txtView.editable = NO;
    txtView.font = [UIFont systemFontOfSize:17];
    txtView.text = @"这里应该加一个AppIcon\n\n    羽秀是一款用于记录羽毛球比赛的APP，通过确认比赛结果，选手们的分数会提高(胜利时)或者降低(失败时)，每一位选手的基础分数是1500分。\n\n    每个选手间相互比赛，将得到对应的水平以及排名。你可以加入公开圈子，或者创建(加入)私密的小圈子。你可以约战同级别的选手，或者挑战高手。\n\n    我们采用类似Dota/LOL排名规则，努力提高APP用户体验，希望大家都能享受羽毛球带给我们的快乐和激情，玩得开心";
    [self.tableView addSubview:txtView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
