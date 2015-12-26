//
//  BSJionCircleViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSJionCircleViewController.h"
#import "BSCircleBusiness.h"

@interface BSJionCircleViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_circleTypeArrM;
    NSMutableDictionary *_circleDict;
    NSUInteger _selectType;
}
@property (weak, nonatomic) IBOutlet UITableView *circleTypeTableView;
@property (weak, nonatomic) IBOutlet UITableView *circleResultTableView;

@end

@implementation BSJionCircleViewController

- (instancetype)init{
    self = [super init];
    if (self) {
       self = [self initWithNibName:@"BSJionCircleViewController" bundle:nil];
        _circleTypeArrM  = @[@"学校",@"公司",@"城市",@"区域",@"小区",@"球会",@"其他"].mutableCopy;
        _selectType = 0;
        _circleDict = [NSMutableDictionary dictionary];
        for (NSString *key in _circleTypeArrM) {
            NSMutableArray *resultArray = [NSMutableArray array];
            [_circleDict setObject:resultArray forKey:key];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.circleTypeTableView) {
        return _circleTypeArrM.count;
    }
    
    NSMutableArray *resultArr = _circleDict[_circleTypeArrM[_selectType]];
    return resultArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.circleTypeTableView) {
        static NSString *CellIdentifier = @"circleTitleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = _circleTypeArrM[indexPath.row];
        cell.imageView.image = UIImageNamed(kDefaultUserAvatar);
        return cell;
    } else {
        static NSString *CellIdentifier = @"circleResultCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [@(indexPath.row) stringValue];

        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.circleResultTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        // 进入圈子主页
        return;
    }
 
    //  点击了圈子类型，查询圈子
    _selectType = indexPath.row;
   __block NSMutableArray *resultArr = _circleDict[_circleTypeArrM[indexPath.row]];
    [resultArr removeAllObjects];
    [BSCircleBusiness  queryCircleWithType:_circleTypeArrM[indexPath.row] block:^(NSArray *objects, NSError *error) {
        resultArr = objects.mutableCopy;
        [tableView reloadData];
    }];
}





@end
