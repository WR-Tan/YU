//
//  BSSelectCircleCategoryController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSelectCircleCategoryController.h"

@interface BSSelectCircleCategoryController () {
    NSMutableArray *_circleTypeArrM;
}
@end

@implementation BSSelectCircleCategoryController


- (instancetype)init{
    self = [super init];
    if (self) {
        self = [self initWithNibName:@"BSJionCircleViewController" bundle:nil];
        _circleTypeArrM  = @[@"公司",@"学校",@"城市",@"区域",@"小区",@"球会",@"其他"].mutableCopy;
//        @[@"宿舍",@"班级",@"家庭",@"部门"].mutableCopy;
        _selectType = 100;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _circleTypeArrM.count;
}


static NSString *cellId = @"cellId";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    cell.accessoryType = (indexPath.row == _selectType) ?UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    cell.textLabel.text = _circleTypeArrM[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectCircleCategory:)]) {
        [self.delegate didSelectCircleCategory: _circleTypeArrM[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
