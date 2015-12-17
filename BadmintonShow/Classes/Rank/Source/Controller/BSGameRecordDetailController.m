//
//  BSGameRecordDetailController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSGameRecordDetailController.h"
#import "BSGameRecordDetailCell.h"

@interface BSGameRecordDetailController ()

@end

@implementation BSGameRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"BSGameRecordDetailCell" bundle:nil] forCellReuseIdentifier:@"BSGameRecordDetailCell"];
    
    [self initNavigationItem];
}

#pragma mark - 初始化导航按钮
- (void)initNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self  action:@selector(shareGame)];
    
}

- (void)shareGame{


}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}



#pragma mark

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BSGameRecordDetailCell";
    BSGameRecordDetailCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BSGameRecordDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.playerAIcon.image = [UIImage imageNamed:@"f_static_084"];
    cell.playerBIcon.image = [UIImage imageNamed:@"f_static_083"];
    
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
