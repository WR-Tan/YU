//
//  BSDiscoverController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSDiscoverController.h"
#import "BSNearbyController.h"
#import "BSRankingsController.h"

@interface BSDiscoverController ()

@end

@implementation BSDiscoverController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;

        self.title = @"发现";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - TableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0){
     
        switch (indexPath.row) {
            case 0:
            {
            
            }
                break;
                
            case 1:
            {
                BSRankingsController *rankings = [[BSRankingsController alloc] init];
                [self.navigationController pushViewController:rankings animated:YES];        
            }
                break;
        }
        
        
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
                
            case 1:
            {
                
            }
                break;
        }
        
        
    }
    else if(indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0: // 附近
            {
                BSNearbyController *nearby = [[BSNearbyController alloc] init];
                [self.navigationController pushViewController:nearby animated:YES];
            }
                break;
                
            case 1:
            {
                
            }
                break;
        }
    }
}


@end
