//
//  BSTimeLineViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/11.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSTimeLineViewController.h"
#import "YYTableView.h"
#import "YYKit.h"

@interface BSTimeLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *layouts;
@end

@implementation BSTimeLineViewController


- (instancetype)init {
    self = [super init];
    _tableView = [YYTableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.919];
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.frame = self.view.bounds;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    if ( kSystemVersion < 7) {
        _tableView.top -= 64;
        _tableView.height += 20;
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
