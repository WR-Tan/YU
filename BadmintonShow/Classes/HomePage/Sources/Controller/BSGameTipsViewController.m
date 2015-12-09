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
        BSGameTipModel *newcommer = [BSGameTipModel gameTipModelWith:@"新手入门" image:newImage];
        BSGameTipModel *middle = [BSGameTipModel gameTipModelWith:@"中级进阶" image:middleImage];
        BSGameTipModel *master = [BSGameTipModel gameTipModelWith:@"高手论剑" image:masterImage];
        
        UIImage *newImage1 = [UIImage imageNamed:@"faqiu_lindan"];
        UIImage *middleImage1 = [UIImage imageNamed:@"jieqiu_lindan"];
        UIImage *masterImage1 = [UIImage imageNamed:@"kousha_lindan"];
        BSGameTipModel *newcommer1 = [BSGameTipModel gameTipModelWith:@"新手入门" image:newImage];
        BSGameTipModel *middle1 = [BSGameTipModel gameTipModelWith:@"中级进阶" image:middleImage];
        BSGameTipModel *master1 = [BSGameTipModel gameTipModelWith:@"高手论剑" image:masterImage];
        
        
        _levelArray = [NSMutableArray arrayWithArray:@[newcommer,middle,master,newcommer1,middle1,master1]];
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
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6 ;// _levelArray.count;
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
