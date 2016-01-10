//
//  BSSwitchCircleView.m
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSwitchCircleView.h"

static  NSUInteger rowHeight = 40;

@interface BSSwitchCircleView () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation BSSwitchCircleView

#pragma mark - public

+ (BSSwitchCircleView *)switchView {
    BSSwitchCircleView *switchView = [[BSSwitchCircleView  alloc] init];
    
    
    return switchView;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
}

#pragma mark - private

- (id)init{
    self = [super init];
    if (!self) return nil;
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
    CGFloat decimal = 200/256.0;
    self.backgroundColor = [UIColor colorWithRed:decimal green:decimal blue:decimal alpha:0.5];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [UIView new];
    [self addSubview:self.tableView];
    
    self.dataArr = @[].mutableCopy;
    return self;
}

- (void)reloadDataWith:(NSArray *)dataArr {
    self.dataArr = dataArr.mutableCopy;
    self.tableView.height = rowHeight * dataArr.count;
    [self.tableView reloadData];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = kBSFontSize(14);
    }
    BSCircleModel *circle = self.dataArr[indexPath.row];
    if ([circle isKindOfClass:[BSCircleModel class]]) {
        cell.textLabel.text = circle.name;
    }
    
    cell.accessoryType = (indexPath.row == _selectedRow) ?
            UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedRow = indexPath.row;
    [self.tableView reloadData];
    
    // BSCircleModel
    BSCircleModel *circle = self.dataArr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(switchView:didSelectCircle:)]) {
        [self.delegate switchView:self didSelectCircle:circle];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}


@end
