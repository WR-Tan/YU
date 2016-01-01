//
//  BSSelectCompanyController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/19/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSelectCompanyController.h"
#import "BSProfileBusiness.h"
#import "BSCommonTool.h"
#import "SVProgressHUD.h"

#define kPadding 20
#define kComViewHeight 40
#define kLabelHeight  40
#define kTextFieldHeight 40

#define kCompanyTag 100
#define kJobTag 200



@interface BSSelectCompanyController () <UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITextField *companyTextField;
@property (nonatomic, strong) UITextField *jobTextField;
@end

@implementation BSSelectCompanyController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = kBackgroudColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self constructBaseView];
     self.navigationItem.rightBarButtonItem =  [BSCommonTool createRightBarButtonItem:@"保存" target:self selector:@selector(saveCompanyInfo) ImageName:nil];
}

- (void)constructBaseView{
    
    self.title = @"公司";
 
    CGFloat comViewY = 60 + 20;
    
    //  公司View
    UIView *comView = [UIView new];
    comView.frame = CGRectMake(0, comViewY, kScreenWidth, 40);
    comView.backgroundColor = [UIColor whiteColor];
    
    UILabel *comLabel = [UILabel new];
    comLabel.text = @"公司";
    comLabel.font = kBSDefaultFont;
    comLabel.frame = CGRectMake(10, 5, 40, 30);
    [comView addSubview:comLabel];
    
    UITextField *comTextField = [UITextField new];
    comTextField.frame = CGRectMake(40 + 10*2 , 5, kScreenWidth - 40 - 10*2 , 30);
    comTextField.placeholder = @"输入你的公司信息";
    comTextField.delegate = self;
    comTextField.font = kBSDefaultFont;
    comTextField.tag = kCompanyTag;
    comTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    [comView addSubview:comTextField];
    
    [self.view addSubview:comView];
    
    
    //  职业View
    UIView *jobView = [UIView new];
    jobView.frame = CGRectMake(0, comView.bottom + 0.5, kScreenWidth, 40);
    jobView.backgroundColor = [UIColor whiteColor];
    
    UILabel *jobLabel = [UILabel new];
    jobLabel.font = kBSDefaultFont;
    jobLabel.text = @"职位";
    jobLabel.frame = CGRectMake(10, 5, 40, 30);
    [jobView addSubview:jobLabel];
    
    UITextField *jobTextField = [UITextField new];
    jobTextField.font = kBSDefaultFont;
    jobTextField.tag = kJobTag;
    jobTextField.delegate = self;
    jobTextField.frame = CGRectMake(40 + 10*2 , 5, kScreenWidth - 40 - 10*2 , 30);
    jobTextField.placeholder = @"输入你的职业信息";
    jobTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [jobView addSubview:jobTextField];
    
    [self.view addSubview:jobView];
    
//    UILabel *infoLabel = [UILabel new];
//    infoLabel.font = kBSFontSize(12);
//    infoLabel.text = @"请输入公司的全名，便于精确匹配与推荐";
//    infoLabel.frame = CGRectMake(10, jobView.bottom + 10, kScreenWidth - 10, 20);
//    [self.view addSubview:infoLabel];
//    // Constarins
    
    self.companyTextField = comTextField;
    self.jobTextField = jobTextField;
}


- (void)saveCompanyInfo{
    NSString *company = self.companyTextField.text ? : @"";
    NSString *job = self.jobTextField.text ? : @"";
    [BSProfileBusiness saveUserObjectArr:@[company,job] keys:@[AVPropertyCompany,AVPropertyJob] block:^(id result, NSError *err) {
        if (err) {
            [SVProgressHUD showErrorWithStatus:@"保存公司信息失败..."];
            return ;
        }
        
        AppContext.user.company = company;
        AppContext.user.job = job ;
        if ([self.delegate respondsToSelector:@selector(updateCompanyInfo)]) {
            [self.delegate updateCompanyInfo];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - ScrollView

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ( kCompanyTag == textField.tag ) {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        [self queryCompanyInfo:newText];
    }
    
    return YES;
}

- (void)queryCompanyInfo:(NSString *)newText{
    [BSProfileBusiness queryCompanyInfoWithKey:newText block:^(id object, NSError *err) {
        /*暂时没用，没用比较好的接口*/
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

