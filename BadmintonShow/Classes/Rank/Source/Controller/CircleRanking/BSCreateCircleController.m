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
#import "BSSelectCircleCategoryController.h"
#import "SVProgressHUD.h"
#import "BSCircleBusiness.h"
#import "BSCircleDetailController.h"
#import "BSCircleModel.h"
#import "BSSetTextViewController.h"
#import "BSProfileEditCell.h"
#import "BSPhotoPicker.h"
#import "YYPhotoGroupView.h"

static NSUInteger nameLengthLimit = 15;

@interface BSCreateCircleController () <BSSelectCircleTypeControllerDelegate,BSSetTextFieldControllerDelegate, BSSelectCircleCategoryControllerDelegate, BSSetTextViewControllerDelegate,BSProfileEditCellDelegate> {

    UIImage *_avatarImage;
    BOOL _isCircleOpen;
    NSString *_circleType;
    NSString *_circleNameStr;
    NSString *_circleCategoryStr;
    NSString *_circleDesc;
}
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *detailArr;
@property (nonatomic, strong) BSProfileModel *avatarItem;

@end

static NSString *cellId = @"BSCreateCircleTypeCell";


static NSString *circleDesc = @"请输入圈子简介/公告";
static NSString *circleType = @"请选择圈子类型";
static NSString *circleCategory = @"请选择圈子分类";
static NSString *circleName = @"请给圈子取一个名字吧";

@implementation BSCreateCircleController

- (instancetype)init{
    self = [super init];
    if (self) {
        _isCircleOpen = YES;
        _detailArr = [NSMutableArray array];
        _circleType = circleType;
        _circleCategoryStr = circleCategory;
        _circleNameStr = circleName;
        _circleDesc = circleDesc;
        self.avatarItem = BSProfileModel(nil, @"头像", nil, nil);
    }
    return self;
}

- (NSMutableArray *)titleArr {
    _titleArr = _isCircleOpen ? @[@"类型",@"分类",@"名称",@"简介"].mutableCopy : @[@"类型",@"名称",@"简介"].mutableCopy;
    return _titleArr;
}

- (NSMutableArray *)detailArr {
    _detailArr = _isCircleOpen ? @[_circleType,_circleCategoryStr,_circleNameStr,_circleDesc].mutableCopy : @[_circleType,_circleNameStr,_circleDesc].mutableCopy;
    return _detailArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"创建圈子";
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

/// 完创建
- (void)complete {
    if (![self validateCircleData]) return;    // 验证圈子数据完整性
    [SVProgressHUD show];
    [BSCircleBusiness queryIfCircleExistsWithName:_circleNameStr block:^(BOOL exists, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
            return ;
        }
        
        if (exists) {
            [SVProgressHUD showErrorWithStatus:@"名称已经存在，请更换其他名称"];
            return ;
        }
        
        [self createCircle];
    }];
}

- (void)createCircle{
    [SVProgressHUD showWithStatus:@"创建中.."];
    
    NSDictionary *categoryDict = [BSCircleBusiness circleCateogry];
    NSString *circleCategory = categoryDict[_circleCategoryStr];
    
    [BSCircleBusiness saveCircleWithName:_circleNameStr category:circleCategory desc:_circleDesc  isOpen:_isCircleOpen  avatar:_avatarImage block:^(id object, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BSCircleModel *model = (BSCircleModel *)object;
            if ( model) {
                [SVProgressHUD showSuccessWithStatus:@"创建成功"];
                BSCircleDetailController *detail =[[BSCircleDetailController alloc ] init];
                detail.circle = model;
                [self.navigationController pushViewController:detail animated:YES];
                return ;
            }
            [SVProgressHUD showErrorWithStatus:@"创建失败..请检查网络并重试"];
        });
    }];

}

///  验证圈子数据
- (BOOL)validateCircleData {
    
//    if (!_avatarImage) {
//        [SVProgressHUD showInfoWithStatus:@"请选择头像"];
//        return NO;
//    }
    
    if ([_circleType isEqualToString:circleType]) {
        [SVProgressHUD showInfoWithStatus:circleType];
        return NO;
    }
    
    if (_isCircleOpen && [_circleCategoryStr isEqualToString:circleCategory]) {
        [SVProgressHUD showInfoWithStatus:circleCategory];
        return NO;
    }
    
    if ([_circleNameStr isEqualToString:circleName]) {
        [SVProgressHUD showInfoWithStatus:circleName];
        return NO;
    }
    
    if ([_circleDesc isEqualToString:circleDesc]) {
        [SVProgressHUD showInfoWithStatus:circleDesc];
        return NO;
    }

    return YES;
}

#pragma mark Cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) return 90;
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
//    if (indexPath.row == 0) {
//        BSProfileEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileEditCell"];
//        if (!cell) {
//            cell = [[BSProfileEditCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BSProfileEditCell"];
//        }
//        cell.object = self.avatarItem;
//        cell.delegate = self;
//        [cell setAvatar:_avatarImage];
//        return cell;
//    }
    
    BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileCell"];
    if (!cell) {
        cell = [[BSProfileCell  alloc] initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:@"BSProfileCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    NSString *detail = self.detailArr[indexPath.row];
    cell.detailTextLabel.text = detail ;
    
    
    if ([detail isEqualToString:circleType] ||
        [detail isEqualToString:circleCategory] ||
        [detail isEqualToString:circleName] ||
        [detail isEqualToString:circleDesc]) {
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }

    

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 0) {
//        [BSPhotoPicker viewController:self pickImageWithBlock:^(id object, NSError *error) {
//            if ([object isKindOfClass:[UIImage class]]) {
//                // 上传图片！成功后将URL赋给item
//                _avatarImage = object;
//                [self.tableView reloadData];
//                
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"获取图片失败"];
//            }
//        }];
//    }
    
    if (indexPath.row == 0) {
        BSSelectCircleTypeController *vc = [[BSSelectCircleTypeController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row == self.titleArr.count - 2) {
        BSSetTextFieldController *nameVC = [[BSSetTextFieldController alloc]init];
        nameVC.title = @"圈子名称";
        nameVC.limitCount = 20;
        nameVC.originalText = _circleNameStr;
        nameVC.placeholder = @"请输入圈子名称（至少2个字）";
        nameVC.delegate = self;
        [self.navigationController pushViewController:nameVC animated:YES];
        return;
    }
    
    if (indexPath.row == 1 && self.titleArr.count == 4) {
        BSSelectCircleCategoryController *categoryVC = [[BSSelectCircleCategoryController alloc] init];
        categoryVC.title = @"选择圈子分类";  //circleResultTableView
        categoryVC.delegate = self;
        [self.navigationController pushViewController:categoryVC animated:YES];
        return;
    }
    
    if (indexPath.row == self.titleArr.count - 1) {
        BSSetTextViewController *descTxtVC = [[BSSetTextViewController alloc] init];
        NSString *text = [_circleDesc isEqualToString:circleDesc] ? @"": _circleDesc;
        descTxtVC.signatureString =  text;
        descTxtVC.title = @"圈子简介";
        descTxtVC.delegate = self;
        descTxtVC.limitCount = 200;
        [self.navigationController pushViewController:descTxtVC animated:YES];
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


- (void)didSelectCircleCategory:(NSString *)category {
    _circleCategoryStr = category;
    [self.tableView reloadData];
}

//  BSSetTextViewControllerDelegate
- (void)resetMessage:(NSString *)message Tag:(int)tag {
    _circleDesc = message;
    [self.tableView reloadData];
}


@end
