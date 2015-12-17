//
//  BSProfileEditViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/15/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileEditViewController.h"
#import "BSProfileEditCell.h"
#import "BSProfileUserModel.h"
#import "BSProfileModel.h"
#import "BSSetTextViewController.h"
#import "BSSetTextFieldController.h"

@interface BSProfileEditViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

/// item for row
@property (nonatomic, strong) BSProfileModel *avatarItem;
@property (nonatomic, strong) BSProfileModel *nameItem;
@property (nonatomic, strong) BSProfileModel *yuxiuItem;
@property (nonatomic, strong) BSProfileModel *QRCodeItem;
@property (nonatomic, strong) BSProfileModel *genderItem;
@property (nonatomic, strong) BSProfileModel *districtItem;
@property (nonatomic, strong) BSProfileModel *signatureItem;
@property (nonatomic, strong) BSProfileModel *schoolItem;
@property (nonatomic, strong) BSProfileModel *companyItem;

@end

@implementation BSProfileEditViewController

- (instancetype)init {
    self = [super init ];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArr = [NSMutableArray array];
        [self createData];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self reloadData];
}

- (void)constructBaseView{
    self.title = @"个人信息";
    
    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    [self.view addSubview:self.tableView];
    
    if ( kSystemVersion < 7) {
        self.tableView.top -= 64;
        self.tableView.height += 20;
    }
}

- (void)reloadData{
    
    [_dataArr removeAllObjects];
    [_dataArr addObject:@[self.avatarItem,self.nameItem,self.yuxiuItem,self.QRCodeItem]];
    [_dataArr addObject:@[self.genderItem,self.districtItem,self.signatureItem]];
    [_dataArr addObject:@[self.schoolItem]];
    [_dataArr addObject:@[self.companyItem]];
    [self.tableView reloadData];
}

- (void)createData{
    
    NSString *defaultURLStr = @"http://h.hiphotos.baidu.com/image/pic/item/4ec2d5628535e5dd2820232370c6a7efce1b623a.jpg";

    //  Section 0
    self.avatarItem = [BSProfileModel new];
    self.avatarItem.thumbnailUrl = defaultURLStr;
    self.avatarItem.title = @"头像";

    self.nameItem = BSProfileModel(nil, @"名字", @"李智华", @"BSSetTextFieldController");
    self.yuxiuItem = BSProfileModel(nil, @"羽秀号", @"swelzh", nil);
    self.QRCodeItem = BSProfileModel(nil, @"我的二维码", @"一起切磋吧", nil);

    //  Section 1
    self.genderItem = BSProfileModel(nil, @"性别", nil, nil);
    self.districtItem = BSProfileModel(nil, @"地区", nil, nil);
    self.signatureItem = BSProfileModel(nil, @"性别", nil, @"BSSetTextViewController");

    //  Section 2
    self.schoolItem = BSProfileModel(nil, @"学校", nil, nil);

    //  Setion 3
    self.companyItem = BSProfileModel(nil, @"公司", nil, nil);
}


#pragma mark - TableView DataSource

#pragma mark Section Header

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark Cell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = _dataArr[section] ;
    return sectionData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) return 90;
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BSProfileEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileEditCell"];
    if (!cell) {
        cell = [[BSProfileEditCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BSProfileEditCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *sectionData = _dataArr[indexPath.section];
    cell.object = sectionData[indexPath.row];
    
    return cell;
}


#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    NSArray  *sectionData = _dataArr[indexPath.section];
    BSProfileModel *profile = sectionData[indexPath.row];
    Class class = NSClassFromString(profile.className);
    if (class) {
        UIViewController *ctrl = class.new ;
        ctrl.view.backgroundColor = [UIColor whiteColor];
        ctrl.title = profile.title;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

#pragma mark - Setter

- (void)setObject:(id)object {
    if (![object isKindOfClass:[BSProfileUserModel class]]) return ;
    if (!object) return;

   
    _userInfo = (BSProfileUserModel *)object;
    self.avatarItem.thumbnailUrl = _userInfo.avatarUrl;
    self.nameItem.detail = _userInfo.nickName;
    self.yuxiuItem.detail = _userInfo.userName;
    self.QRCodeItem.detail = _userInfo.QRCode;
    self.genderItem.detail = _userInfo.genderStr;
    self.districtItem.detail = [NSString stringWithFormat:@"%@ %@",
                                _userInfo.province?:@"",_userInfo.city?:@""];
    self.signatureItem.detail = _userInfo.desc;
    self.schoolItem.detail = _userInfo.school;
    self.companyItem.detail = _userInfo.company;
    
    [self reloadData];
}



@end
