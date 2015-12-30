//
//  BSPlayerDetailViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSPlayerDetailViewController.h"
#import "BSPlayerDetailHeader.h"

@interface BSPlayerDetailViewController ()
@property (nonatomic, strong) BSPlayerDetailHeader *header;
@end

@implementation BSPlayerDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
   

    CGFloat buttonHeight = 50;
    CGFloat buttonWidth = kScreenWidth - 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, self.view.height - buttonHeight - 64, buttonWidth, 40 - 5);
    [button setBackgroundColor:[UIColor blueColor] ];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"加为好友" forState:UIControlStateNormal];
    [button addTarget:self  action:@selector(makeFriend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

//  加为好友
- (void)makeFriend{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 500;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_header) {
        _header  = [BSPlayerDetailHeader new];
    }
    return _header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
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
