
//
//  BSSetGameTypeController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSetGameTypeController.h"
#import "BSProfileCell.h"
#import "BSProfileModel.h"
#import "AVUser.h"


@interface BSSetGameTypeController ()
@property (nonatomic, strong)  NSMutableArray *dataArr;

@end

@implementation BSSetGameTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    BSProfileModel *manSingle = BSProfileModel(nil,@"男单",nil,nil);
    BSProfileModel *menDouble = BSProfileModel(nil,@"男双",nil,nil);
    BSProfileModel *womanSingle = BSProfileModel(nil,@"女单",nil,nil);
    BSProfileModel *womenDouble = BSProfileModel(nil,@"女双",nil,nil);
    BSProfileModel *mixDouble = BSProfileModel(nil,@"混双",nil,nil);
    
    if ([AppContext.user.genderStr isEqualToString:@"U"]) {
        [MBProgressHUD showText:@"请设置自己的性别哦" atView:self.view animated:YES];
        self.dataArr =@[manSingle,menDouble,womanSingle,womenDouble,mixDouble].mutableCopy;
    } else if ([AppContext.user.genderStr isEqualToString:@"M"]) {
        self.dataArr =@[manSingle,menDouble,mixDouble].mutableCopy;
    } else {
        self.dataArr =@[womanSingle,womenDouble,mixDouble].mutableCopy;
    }

    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"BSProfileCell";
    BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BSProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.object = self.dataArr[indexPath.row];
    
    cell.accessoryType = (indexPath.row == (NSInteger)self.bmtGameType ) ?
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BMTGameType selectedGameType ;
    
    if ([AppContext.user.genderStr isEqualToString:@"U"]) {
        selectedGameType = indexPath.row;
    }else if ([AppContext.user.genderStr isEqualToString:@"F"]) {
        selectedGameType = (indexPath.row == 0) ? BMTGameTypeWomanSingle :
                          ((indexPath.row == 1) ? BMTGameTypeWomenDouble : BMTGameTypeMixDouble);
    }else if ([AppContext.user.genderStr isEqualToString:@"M"]){
        selectedGameType = (indexPath.row == 0) ? BMTGameTypeManSingle :
                          ((indexPath.row == 1) ? BMTGameTypeMenDouble : BMTGameTypeMixDouble);
    }
    
    if (selectedGameType == BMTGameTypeMenDouble || selectedGameType == BMTGameTypeWomenDouble || selectedGameType == BMTGameTypeMixDouble) {
        [MBProgressHUD showText:@"双打将在下个版本支持,敬请期待" atView:self.view animated:YES];
        return;
    }
    
    self.bmtGameType = selectedGameType;
    [tableView reloadData];
    [BSAddGameBusiness setBMTGameTypeToUserDefault:self.bmtGameType];
    if ([self.delegate respondsToSelector:@selector(selectedBMTGameType:)]) {
        [self.delegate selectedBMTGameType:self.bmtGameType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
