//
//  BSSelectSchoolController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/19/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSelectSchoolController.h"
#import "BSProfileBusiness.h"
#import "BSCommonTool.h"
#import "SVProgressHUD.h"
#import "PAFFDatePicker.h"

#define kSchoolBtnSelectedBG @"Tables_Arrow"
// 文字的高度比例
#define kTitleRatio 0.3
#define kTitleWidthRatio 0.5

#pragma mark - LeftTitleButton
///==================================================
/// @name LeftTitleButton
///=================================================

@interface LeftTitleButton : UIButton
@end

@implementation LeftTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageWidth = 27 ;
    CGFloat imageHeight = 39 ;
    CGFloat imageX = contentRect.size.width - imageWidth - 10;
    CGFloat imageY = 0;

    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 10;
    CGFloat titleHeight = contentRect.size.height ;
    CGFloat titleY = 0 ;
    CGFloat titleWidth = contentRect.size.width * kTitleWidthRatio;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end

#pragma mark - BSSelectSchoolController
///======================================================
/// @name BSSelectSchoolController
///======================================================



@interface BSSelectSchoolController ()<UITextFieldDelegate,PAFFCustomModalViewDelegate>
@property (nonatomic, strong) UITextField *schoolTextField;
@property (nonatomic, strong) UIButton *accessYearBtn;
@end

@implementation BSSelectSchoolController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = kBackgroudColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    self.navigationItem.rightBarButtonItem =  [BSCommonTool createRightBarButtonItem:@"保存" target:self selector:@selector(saveSchoolInfo) ImageName:nil];
}

- (void)constructBaseView{
    self.title = @"学校";
    
    CGFloat comViewY = 60 + 20;
    //  公司View
    UIView *comView = [UIView new];
    comView.frame = CGRectMake(0, comViewY, kScreenWidth, 40);
    comView.backgroundColor = [UIColor whiteColor];
    
    UITextField *schoolTextField = [UITextField new];
    schoolTextField.frame = CGRectMake(10 , 5, kScreenWidth - 10*2 , 30);
    schoolTextField.placeholder = @"输入你的学校名称";
    schoolTextField.delegate = self;
    schoolTextField.font = kBSDefaultFont;
    schoolTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [comView addSubview:schoolTextField];
    self.schoolTextField = schoolTextField;
    
    [self.view addSubview:comView];
    
    
    //  职业View
    UIView *accessYearBgView = [UIView new];
    accessYearBgView.frame = CGRectMake(0, comView.bottom + 0.5, kScreenWidth, 40);
    accessYearBgView.backgroundColor = [UIColor whiteColor];
    
    LeftTitleButton *accessYearBtn = [LeftTitleButton buttonWithType:UIButtonTypeCustom];
    accessYearBtn.titleLabel.font = kBSDefaultFont;
    accessYearBtn.frame = accessYearBgView.bounds;
//    accessYearBtn.titleLabel.textColor = [UIColor blackColor];
    [accessYearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [accessYearBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [accessYearBtn setTitle:@"请选择入学时间" forState:UIControlStateNormal] ;
    [accessYearBtn setImage:[UIImage imageNamed:kSchoolBtnSelectedBG] forState:UIControlStateNormal];
    [accessYearBtn addTarget:self action:@selector(selectAccessYear) forControlEvents:UIControlEventTouchUpInside];
    [accessYearBgView addSubview:accessYearBtn];
    
    [self.view addSubview:accessYearBgView];
    
    UILabel *infoLabel = [UILabel new];
    infoLabel.font = kBSFontSize(12);
    infoLabel.text = @"请输入学校的全名，便于精确匹配与推荐";
    infoLabel.frame = CGRectMake(10, accessYearBgView.bottom + 10, kScreenWidth - 10, 20);
    [self.view addSubview:infoLabel];
    // Constarins
    

    self.accessYearBtn = accessYearBtn;
}

- (void)selectAccessYear{
    [self.view endEditing:YES];
    
    __block PAFFDatePicker *datePicker =
    [[PAFFDatePicker alloc] initWithframe:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 216)
                              PickerStyle:UUDateStyle_YearMonth
                              didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
                                  datePicker.backString = [NSString stringWithFormat:@"%@年%@月%@日", year, month, day];
                              }];
    datePicker.titleLabel.text = @"选择入学时间";
    datePicker.titleLabel.left = -50;
    datePicker.ScrollToDate = [NSDate date];
    datePicker.maxLimitDate = [NSDate date];
    datePicker.delegate = self;
    [datePicker show];
}

- (void)customModalView:(PAFFCustomModalView *)custom selectString:(NSString *)selectString {
    NSString *accessSchoolTime = [[selectString componentsSeparatedByString:@"月"] firstObject];
    accessSchoolTime = [accessSchoolTime stringByAppendingString:@"月"];
    [self.accessYearBtn setTitle:(accessSchoolTime?:@"") forState:UIControlStateNormal];
}


- (void)saveSchoolInfo{
    NSString *school = self.schoolTextField.text ? : @"";
    NSString *accessSchoolTime = [self accessSchoolTime];
    [BSProfileBusiness saveUserObjectArr:@[school,accessSchoolTime] keys:@[AVPropertyCompany,AVPropertyAccessSchoolTime] block:^(id result, NSError *err) {
        if (err) {
            [SVProgressHUD showErrorWithStatus:@"保存学校信息失败..."];
            return ;
        }
        AppContext.user.school = school;
        AppContext.user.accessSchoolTime = accessSchoolTime ;
        if ([self.delegate respondsToSelector:@selector(updateSchoolInfo)]) {
            [self.delegate updateSchoolInfo];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSString *)accessSchoolTime{
    //   去掉年月
    NSString *time = [self.accessYearBtn titleForState:UIControlStateNormal]  ? : @"";
    time = [time stringByReplacingOccurrencesOfString:@"月" withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    return time?:@"";
}

#pragma mark - ScrollView

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self querySchoolInfo:newText];
    return YES;
}

- (void)querySchoolInfo:(NSString *)newText{
    /*没用接口，先让用户自己填好了*/
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end




