//
//  BSCreateCircleController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCreateCircleController.h"
#import "BSCreateCircleTypeCell.h"
#import "BSProfileModel.h"
#import "BSProfileCell.h"
#import "BSSelectCircleTypeController.h"
#import "BSSetTextFieldController.h"
#import "SVProgressHUD.h"

static NSUInteger nameLengthLimit = 15;

@interface BSCreateCircleController () <BSSelectCircleTypeControllerDelegate,BSSetTextFieldControllerDelegate> {

    
    BOOL _isCircleOpen;
    NSString *_circleType;
    NSString *_circleNameStr;
    NSString *_circleCategoryStr;
}
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *detailArr;
@end

static NSString *cellId = @"BSCreateCircleTypeCell";

@implementation BSCreateCircleController

- (instancetype)init{
    self = [super init];
    if (self) {
        _isCircleOpen = YES;
        _detailArr = [NSMutableArray array];
        _circleType = @"请选择圈子类型";
        _circleCategoryStr = @"请选择圈子分类";
        _circleNameStr = @"请给圈子取一个名字吧";
    }
    return self;
}

- (NSMutableArray *)titleArr {
    _titleArr = _isCircleOpen ? @[@"类型",@"分类",@"名称"].mutableCopy : @[@"类型",@"名称"].mutableCopy;
    return _titleArr;
}

- (NSMutableArray *)detailArr {
    _titleArr = _isCircleOpen ? @[_circleType,_circleCategoryStr,_circleNameStr].mutableCopy : @[_circleType,_circleNameStr].mutableCopy;
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"创建圈子";
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark Cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileCell"];
    if (!cell) {
        cell = [[BSProfileCell  alloc] initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:@"BSProfileCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    NSString *detail = self.detailArr[indexPath.row];
    cell.detailTextLabel.text = detail ;
    
    
    if ([detail isEqualToString:@"请选择圈子类型"] ||
        [detail isEqualToString:@"请选择圈子分类"] ||
        [detail isEqualToString:@"请给圈子取一个名字吧"] ) {
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }

    

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        BSSelectCircleTypeController *vc = [[BSSelectCircleTypeController alloc] init];vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == self.titleArr.count - 1) {
        BSSetTextFieldController *nameVC = [[BSSetTextFieldController alloc]init];
        nameVC.title = @"圈子名称";
        nameVC.placeholder = @"请输入圈子名称（至少2个字）";
        nameVC.delegate = self;
        [self.navigationController pushViewController:nameVC animated:YES];
        return;
    }
}

-(void)didSelectOpenType:(BSCircleOpenType)openType {
    _isCircleOpen = (openType == BSCircleOpenTypeOpen) ? YES : NO ;
    _circleType = _isCircleOpen ? @"公开圈" : @"私密圈";
    [self.tableView reloadData];
}

/// 圈子名称
-(void)resetText:(NSString *)text Tag:(int)tag {
    if (text.length < 2 || text.length > nameLengthLimit ) {
        NSString *limitStr = [NSString stringWithFormat:@"名称不能少于%d个字，或多于%ld个字",2,nameLengthLimit];
        [SVProgressHUD showErrorWithStatus:limitStr];
        return;
    }
    
    _circleNameStr = text;
    [self.tableView reloadData];
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
