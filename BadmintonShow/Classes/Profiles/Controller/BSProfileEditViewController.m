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
#import "BSProfileBusiness.h"
#import "YYPhotoGroupView.h"
#import <AVFoundation/AVFoundation.h>
#import "SVProgressHUD.h"
#import "BSSelectGenderController.h"
#import "PAFFDatePicker.h"
#import "CNCityPickerView.h"
#import "BSSelectCompanyController.h"
#import "BSSelectSchoolController.h"


@interface BSProfileEditViewController () <BSProfileEditCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,BSSetTextFieldControllerDelegate,BSSetTextViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,BSSelectGenderControllerDelegate,PAFFCustomModalViewDelegate,BSSelectSchoolControllerDelegate,BSSelectCompanyControllerDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;

/// item for row
@property (nonatomic, strong) BSProfileModel *avatarItem;
@property (nonatomic, strong) BSProfileModel *nameItem;
@property (nonatomic, strong) BSProfileModel *yuxiuItem;
@property (nonatomic, strong) BSProfileModel *genderItem;
@property (nonatomic, strong) BSProfileModel *districtItem;
@property (nonatomic, strong) BSProfileModel *signatureItem;
@property (nonatomic, strong) BSProfileModel *schoolItem;
@property (nonatomic, strong) BSProfileModel *companyItem;

@property (nonatomic, strong) BSProfileModel *ageItem;
@property (nonatomic, strong) BSProfileModel *birthdayItem;

@end

@implementation BSProfileEditViewController

- (instancetype)init {
    self = [super init ];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArr = [NSMutableArray array];
        [self initData];
        [self updateRowItems];
        [self reloadData];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self getUserInfoFromNet];
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

- (void)getUserInfoFromNet{
    [BSProfileBusiness getProflieMessageFromNet:^(BSProfileUserModel *profileUserMoel, NSError *err) {
        if (err) return ;
        [self updateRowItems];
        [self reloadData];
        if ([self.delegate respondsToSelector:@selector(updateUseInfo)]) {
            [self.delegate updateUseInfo];
        }
    }];
}

- (void)reloadData{
    
    [_dataArr removeAllObjects];
    [_dataArr addObject:@[self.avatarItem,self.nameItem,self.yuxiuItem]];
    [_dataArr addObject:@[self.genderItem,self.birthdayItem,self.districtItem,self.signatureItem]];
    [_dataArr addObject:@[self.schoolItem]];
    [_dataArr addObject:@[self.companyItem]];
    [self.tableView reloadData];
}

- (void)initData{
    
    NSString *defaultURLStr = @"http://h.hiphotos.baidu.com/image/pic/item/4ec2d5628535e5dd2820232370c6a7efce1b623a.jpg";
    //  Section 0
    self.avatarItem = [BSProfileModel new];
    self.avatarItem.thumbnailUrl = defaultURLStr;
    self.avatarItem.title = @"头像";
    self.nameItem = BSProfileModel(nil, @"昵称", nil, @"BSSetTextFieldController");
    self.yuxiuItem = BSProfileModel(nil, @"羽秀号", nil, nil);
    //  Section 1
    
    self.genderItem = BSProfileModel(nil, @"性别", nil, nil);
    self.ageItem = BSProfileModel(nil, @"年龄", nil, nil);
    self.districtItem = BSProfileModel(nil, @"地区", nil, nil);
    self.signatureItem = BSProfileModel(nil, @"简介", nil, @"BSSetTextViewController");

    self.birthdayItem = BSProfileModel(nil, @"生日", nil, nil);
    //  Section 2
    self.schoolItem = BSProfileModel(nil, @"学校", nil, nil);
    //  Setion 3
    self.companyItem = BSProfileModel(nil, @"公司", nil, nil);

    
}

- (void)updateRowItems {
    
    self.avatarItem.thumbnailUrl = AppContext.user.avatarUrl;
    self.nameItem.detail = AppContext.user.nickName;
    self.yuxiuItem.detail = AppContext.user.userName;
    self.genderItem.detail = AppContext.user.genderStr;
    self.birthdayItem.detail = AppContext.user.birthdayStr;
    
    self.districtItem.detail = [NSString stringWithFormat:@"%@ %@", AppContext.user.city?:@"",AppContext.user.disctrit?:@""];
    
    self.signatureItem.detail = AppContext.user.desc;
    
    NSString *accessSchoolYear = [[AppContext.user .accessSchoolTime componentsSeparatedByString:@"-"] firstObject];
    accessSchoolYear = [accessSchoolYear substringWithRange:NSMakeRange(2, 2)];
    self.schoolItem.detail = [NSString stringWithFormat:@"%@ %@级",AppContext.user.school,accessSchoolYear];
    self.companyItem.detail = AppContext.user.company;
    //    self.ageItem.detail =  [self ageFromDate:AppContext.user.birthday] ;
    
    NSDate *bir = [NSDate dateWithTimeIntervalSinceNow:- 60* 60 * 24 * 366];
    self.ageItem.detail =  [self ageFromDate:bir] ;
}


#pragma mark - TableView DataSource

#pragma mark Section Header

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section ? 20 : 0.1;
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
    }
    NSArray *sectionData = _dataArr[indexPath.section];
    cell.object = sectionData[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger row = indexPath.section * 10 + indexPath.row;
    switch (row) {
        case 0 : { [self changeAvatar];  /*修改头像*/  } break;
        case 1 : { [self setNickName];  /*修改昵称*/  } break;
        case 10: { [self selectGender];  /*性别*/  } break;
        case 11: { [self selectBirthdayDate];  /*生日*/ } break;
        case 12: { [self selectRegion];  /*地区*/ } break;
        case 13: { [self setSignatureDesc];  /*简介*/ } break;
        case 20: { [self setSchoolInfo];  /*简介*/ } break;
        case 30: { [self setCompanyInfo];  /*简介*/ } break;
            
        default: break;
    }
}

#pragma mark - 修改头像

- (void)changeAvatar{
    [self initActionSheet];
}

#pragma mark 修改昵称

- (void)setNickName {
    BSSetTextFieldController *tfVC = [BSSetTextFieldController new];
    tfVC.originalText = AppContext.user.nickName;
    tfVC.delegate = self;
    tfVC.title = @"名字";
    [self.navigationController pushViewController:tfVC animated:YES];
}

#pragma mark 修改性别

- (void)selectGender{
    BSSelectGenderController *selectGender = [[BSSelectGenderController alloc] init];
    NSUInteger gender =[AppContext.user.genderStr isEqualToString:@"M"] ? 0 : ( [AppContext.user.genderStr isEqualToString:@"F"] ? 1 : 2);
    selectGender.gender = gender;
    selectGender.delegate = self;
    [self.navigationController pushViewController:selectGender animated:YES];
}

#pragma mark 修改生日

- (void)selectBirthdayDate{
    
    __block PAFFDatePicker *datePicker =
    [[PAFFDatePicker alloc] initWithframe:CGRectMake(0, [UIScreen mainScreen].bounds.size.height,
                                                     [UIScreen mainScreen].bounds.size.width, 216)
                              PickerStyle:1
                              didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour,
                                            NSString *minute, NSString *weekDay) {
                                  datePicker.backString =
                                  [NSString stringWithFormat:@"%@年%@月%@日", year, month, day];
                              }];
    datePicker.titleLabel.text = @"生日";
    datePicker.titleLabel.left = 20;
    datePicker.ScrollToDate = [NSDate date];
    datePicker.maxLimitDate = [NSDate date];
    datePicker.delegate = self;
    [datePicker show];
}

#pragma mark 修改地区

- (void)selectRegion{
    
    __block CNCityPickerView *datePicker =
    [[CNCityPickerView alloc] initWithframe:CGRectMake(0, [UIScreen mainScreen].bounds.size.height,
                                                     [UIScreen mainScreen].bounds.size.width, 216) didSelected:^(NSString *province, NSString *city, NSString *area) {
         
    }];
    
    datePicker.titleLabel.text = @"选择地区";
    datePicker.titleLabel.left = -70;
    datePicker.delegate = self;
    [datePicker show];
}

#pragma mark 修改签名
- (void)setSignatureDesc{
    BSSetTextViewController *descVC = [[BSSetTextViewController alloc] init];
    descVC.signatureString = AppContext.user.desc ;
    descVC.delegate = self;
    [self.navigationController pushViewController:descVC animated:YES];
}


#pragma mark 修改学校

- (void)setSchoolInfo{
    BSSelectSchoolController *schoolVC = [[BSSelectSchoolController alloc] init];
    schoolVC.delegate = self;
    [self.navigationController pushViewController:schoolVC animated:YES];
}

- (void)updateSchoolInfo{
    [self updateRowItems];
    [self reloadData];
}

#pragma mark 修改公司

- (void)setCompanyInfo{
    BSSelectCompanyController *company = [BSSelectCompanyController new];
    company.delegate = self;
    [self.navigationController pushViewController:company animated:YES];
}

- (void)updateCompanyInfo {
    [self updateRowItems];
    [self reloadData];
}


#pragma mark BSSetTextViewControllerDelegate

- (void)resetMessage:(NSString *)message Tag:(int)tag {
    [BSProfileBusiness saveUserObject:message key:AVPropertyDesc block:^(id object, NSError *err) {
        if (!err) {
            AppContext.user.desc = message;
            [self updateRowItems];
            [self reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"保存昵称失败..." maskType:SVProgressHUDMaskTypeBlack];
        }
    }];

}

#pragma mark BSSetTextFieldControllerDelegate

- (void)resetText:(NSString *)text Tag:(int)tag {
    [BSProfileBusiness saveUserObject:text key:AVPropertyNickName block:^(id object, NSError *err) {
        if (!err) {
            AppContext.user.nickName = text;
            [self updateRowItems];
            [self reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"保存昵称失败..." maskType:SVProgressHUDMaskTypeBlack];
        }
    }];
}

#pragma mark Select Gender

- (void)updateUserGender{
    [self updateRowItems];
    [self reloadData];
}


#pragma mark CustomModalDelegate
- (void)customModalView:(PAFFCustomModalView *)custom selectString:(NSString *)selectString {

    if ([custom isKindOfClass:[PAFFDatePicker class]]) {
        [self handleDateString:selectString];
        return;
    }
    
    if ([custom isKindOfClass:[CNCityPickerView class]]) {
        [self handleRegion:selectString];
    }
}

/// 处理返回的生日str
- (void)handleDateString:(NSString *)dateStr{
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
    [BSProfileBusiness saveUserObject:dateStr key:AVPropertyBirthDayStr block:^(id result, NSError *err) {
        if (err) {
            [SVProgressHUD showErrorWithStatus:@"保存生日失败"];
            return ;
        }
        AppContext.user.birthdayStr = dateStr;
        [self updateRowItems];
        [self reloadData];
    }];
}
/// 处理返回的地区（广东 深圳 南山区）
- (void)handleRegion:(NSString *)region{
    NSArray *addressArr = [region componentsSeparatedByString:@" "];
    
    // 取出省名，城市名，区名
    NSString *province = addressArr.count > 0 ? addressArr[0] : @"";
    if ([province isEqualToString:@"上海"] || [province isEqualToString:@"北京"] || [province isEqualToString:@"天津"]) {
        province = @"";
    }
    
    NSString *city =  addressArr.count > 1 ? addressArr[1] : @"";
    NSString *disctrit =  addressArr.count > 2 ? addressArr[2] : @"";
    
    
    [BSProfileBusiness saveUserObjectArr:@[province,city,disctrit]
        keys:@[AVPropertyProvince,AVPropertyCity,AVPropertyDisctrict] block:^(id result, NSError *err) {
            
            if (err) {
                [SVProgressHUD showErrorWithStatus:@"保存地区失败"];
                return ;
            }
            AppContext.user.province = province;
            AppContext.user.city = city;
            AppContext.user.disctrit = disctrit;
            [self updateRowItems];
            [self reloadData];
    }];
}


#pragma mark BSProfileEditCellDelegate

- (void)cell:(BSProfileEditCell *)cell imageView:(UIImageView *)imageView displayImageUrl:(NSString *)imageUrl {
    if (!imageUrl) return;
    
    YYPhotoGroupItem *item = [YYPhotoGroupItem new];
    item.largeImageURL = [NSURL URLWithString:imageUrl];
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
    [v presentFromImageView:imageView toContainer:self.navigationController.view animated:YES completion:nil];
}


#pragma mark UIImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:^{
        if(image){
            [SVProgressHUD showWithStatus:@"图片上传中"];
            [self uploadAvatar:image];
        }else{
            [SVProgressHUD showErrorWithStatus:@"图像获取失败"];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadAvatar:(UIImage *)avatar {
    [BSProfileBusiness uploadAvatar:avatar result:^(id object, NSError *err) {
        [SVProgressHUD dismiss];
        if (err) {
            [SVProgressHUD showErrorWithStatus:@"上传头像失败..."];
        } else {
            [self getUserInfoFromNet];
        }
    }];
}

#pragma mark 头像ActionSheet

- (void)initActionSheet {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7 &&
        [[UIDevice currentDevice].systemVersion doubleValue] < 8) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
        [actionSheet showFromRect:CGRectMake(0, 0, kScreenWidth, kScreenHeigth / 2) inView:self.tableView animated:YES];
    }
    
    else if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8) {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:nil  message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self takePhotoAction];
        }];
        
        UIAlertAction *pickPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openPhotoAlbumAction];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:takePhoto];
        [alertController addAction:pickPhoto];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: return;  break;
        case 1: { [self takePhotoAction]; }  break;
        case 2: { [self openPhotoAlbumAction]; } break;
        default: break;
    }
}

- (void)takePhotoAction {
    [self takePhotoType:UIImagePickerControllerSourceTypeCamera];
}

- (void)openPhotoAlbumAction {
    [self takePhotoType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)takePhotoType:(UIImagePickerControllerSourceType)type
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        // do your logic
        if ([UIImagePickerController isSourceTypeAvailable:type]) {
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = type;
            pickerController.allowsEditing = YES;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:@"该设备无相机"];
        }
        
    } else if (authStatus == AVAuthorizationStatusDenied) {
        // denied
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设备的：设置-隐私-相机 中允许访问相机。"
                                  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        // restricted, normally won't happen
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // not determined?!
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     if (granted) {
                                         //                NSLog(@"Granted access to %@", AVMediaTypeVideo);
                                     } else {
                                         //                NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                                     }
                                 }];
    } else {
        // impossible, unknown authorization status
    }
    
}

//根据日期来计算年龄
- (NSString*)ageFromDate:(NSDate*)birthday{
    NSDate *myDate = birthday;
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitYear;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:myDate toDate:nowDate options:0];
    NSUInteger year = [comps year];
    return [NSString stringWithFormat:@"%lu",(unsigned long)year];
}


@end
