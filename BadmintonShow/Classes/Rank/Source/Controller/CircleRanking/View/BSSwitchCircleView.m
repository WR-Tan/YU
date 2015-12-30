//
//  BSSwitchCircleView.m
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSwitchCircleView.h"


@interface BSSwitchCircleView () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation BSSwitchCircleView

- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSSwitchCircleView" owner:nil options:nil] lastObject];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataArr = @[@[@"公司",@"学校",@"城市",@"小区"]/*,@[@"桂八"]*/].mutableCopy;
    return self;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

+ (BSSwitchCircleView *)switchView {
    BSSwitchCircleView *switchView = [[BSSwitchCircleView alloc] init];
    CGFloat width = 100;
    CGFloat height = 200;
    CGFloat x = (kScreenWidth - width) / 2;
    CGFloat y = 5;
    switchView.frame = CGRectMake(x, y, width, height);
    return switchView;
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionData = self.dataArr[section];
    return sectionData.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSArray *sectionData = self.dataArr[section];
//    return sectionData.count ? @"私密圈" : nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20.0f;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSArray *sectionData = self.dataArr[indexPath.section];
    cell.textLabel.text = sectionData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // BSCircelModel
//    NSArray *sectionData = self.dataArr[indexPath.section];
//    BSCircelModel *circle = sectionData[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(switchView:didSelectCircle:)]) {
        [self.delegate switchView:self didSelectCircle:nil];
    }
}





@end
