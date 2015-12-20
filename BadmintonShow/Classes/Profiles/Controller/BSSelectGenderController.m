//
//  BSSelectGenderController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/19/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSelectGenderController.h"
#import "BSProfileBusiness.h"
#import "SVProgressHUD.h"

@interface BSSelectGenderController ()
@property (nonatomic, strong) NSArray *genderArr;
@end

@implementation BSSelectGenderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _genderArr = @[@"男",@"女",@"保密"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _genderArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    cell.textLabel.text = _genderArr[indexPath.row];
    cell.accessoryType = _gender == indexPath.row ?
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self saveGenderInBackgroundWithIndex:indexPath.row];
}

- (void)saveGenderInBackgroundWithIndex:(NSInteger)row{
    _gender = row;
    [self.tableView reloadData];
    
    NSString *genderStr = @[@"M",@"F",@"U"][row];
    [BSProfileBusiness saveUserObject:genderStr  key:AVPropertyGenderStr block:^(id result, NSError *err) {
       
        if (err) {
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
            return ;
        }
        
        AppContext.user.genderStr = genderStr;
        if ([self.delegate respondsToSelector:@selector(updateUserGender)]) {
            [self.delegate updateUserGender];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
