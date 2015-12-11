//
//  BSGameTipsViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameTipsViewController.h"
#import "BSGameTipCell.h"
#import "BSGameTipModel.h"
#import "BSSmashGIFViewController.h"

@interface BSGameTipsViewController ()
{
    NSMutableArray *_levelArray ;
}
@end

static NSString *gameTipCellId = @"gameTipCellId";

@implementation BSGameTipsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *newImage = [UIImage imageNamed:@"faqiu_lindan"];
        UIImage *middleImage = [UIImage imageNamed:@"jieqiu_lindan"];
        UIImage *masterImage = [UIImage imageNamed:@"kousha_lindan"];
        BSGameTipModel *newcommer = [BSGameTipModel gameTipModelWith:@"发球" image:newImage];
        BSGameTipModel *middle = [BSGameTipModel gameTipModelWith:@"步法" image:middleImage];
        BSGameTipModel *master = [BSGameTipModel gameTipModelWith:@"扣球" image:masterImage];

        
        
        _levelArray = [NSMutableArray arrayWithArray:@[newcommer,middle,master]];
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

#pragma mark -  TableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BSGameTipCell *cell = [tableView dequeueReusableCellWithIdentifier:gameTipCellId];
    if (!cell) {
        cell = [[BSGameTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gameTipCellId];
    }
    
    BSGameTipModel *model = [_levelArray objectAtIndex:indexPath.row];

    cell.titleLabel.text = model.title ;
    cell.imgView.image = model.image ;
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill ;
    cell.imgView.clipsToBounds = YES ;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _levelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    BSSmashGIFViewController *smash = [[BSSmashGIFViewController alloc] init];
    [self.navigationController pushViewController:smash animated:YES];
    
}

@end
