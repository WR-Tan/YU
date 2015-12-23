
//
//  BSSetTextFieldController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSetTextFieldController.h"
#import "BSCommonTool.h"
#import "BSProfileBusiness.h"
#import "SVProgressHUD.h"

#define kTextFieldPadding 15 
#define kTextFieldHeight  35

@interface BSSetTextFieldController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation BSSetTextFieldController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroudColor;
    
    self.navigationItem.rightBarButtonItem = [BSCommonTool createRightBarButtonItem:@"保存" target:self selector:@selector(backtohome) ImageName:@""];
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:
              CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    scroll.backgroundColor = kBackgroudColor;
    
    self.textField = [[UITextField alloc] initWithFrame:
               CGRectMake(kTextFieldPadding, 0, kScreenWidth - kTextFieldPadding * 2, kTextFieldHeight)];
    [self.textField setAccessibilityLabel:@"地址输入框"];
    [self.textField becomeFirstResponder];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.font = kBSDefaultFont;
    self.textField.delegate = self;
    self.textField.text = self.originalText;
    self.textField.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.8f];
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIView *textBackgroudView = [UIView new];
    textBackgroudView.backgroundColor = [UIColor whiteColor];
    textBackgroudView.frame = CGRectMake(0, 20, kScreenWidth, self.textField.frame.size.height);
    [textBackgroudView addSubview:self.textField];
    
    [scroll addSubview:textBackgroudView];
    [self.view addSubview:scroll];
}

- (void)backtohome{
    [self.view endEditing:YES];
    
    
    NSString *warnStr ;
    if (self.textField.text.length >= 15 || self.textField.text.length == 0) {
        warnStr = self.textField.text.length >= 15 ? @"昵称不能超过15字哦" : @"昵称不能为空哦";
        [SVProgressHUD showErrorWithStatus:warnStr maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    [self.delegate resetText:(self.textField.text?:@"") Tag:self.tag];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) return YES;
    if (textField.text.length >= 30) return NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return NO;
}

@end
