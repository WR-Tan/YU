//
//  SetTextViewController.m
//  PAYZT
//
//  Created by 何广忠 on 14-6-3.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import "BSSetTextViewController.h"
#import "SIAlertView.h"
#import "BSCommonTool.h"

#define kMaxLenth 30

#define kTextViewPadding  10
#define kTextViewHeight   140

@interface BSSetTextViewController  () <UITextViewDelegate, UIAlertViewDelegate> {
    UITextView *txtView;
    BOOL isFirst;
    UIScrollView *scroll;
    UILabel *textNumLabel;
    BOOL bIsThisView;
}

@end

@implementation BSSetTextViewController 

#pragma mark - <Life Cycle>
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    bIsThisView = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    bIsThisView = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bIsThisView = NO;
    self.view.backgroundColor = kBackgroudColor;
    self.navigationItem.rightBarButtonItem = [BSCommonTool createRightBarButtonItem:@"保存" target:self selector:@selector(backtohome) ImageName:@""];
    isFirst = YES;
    scroll = [[UIScrollView alloc]initWithFrame:
              CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    scroll.backgroundColor = kBackgroudColor;
    
    txtView = [[UITextView alloc] initWithFrame:
               CGRectMake(kTextViewPadding, 0, kScreenWidth - kTextViewPadding * 2, kTextViewHeight)];
    [txtView setAccessibilityLabel:@"地址输入框"];
    [txtView becomeFirstResponder];
    txtView.returnKeyType = UIReturnKeyDone;
    txtView.font = kBSDefaultFont;
    txtView.delegate = self;
    txtView.text=self.signatureString;
    txtView.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.8f];
    txtView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIView *textBackgroudView = [UIView new];
    textBackgroudView.backgroundColor = [UIColor whiteColor];
    textBackgroudView.frame = CGRectMake(0, 20, kScreenWidth, txtView.frame.size.height);
    [textBackgroudView addSubview:txtView];
    
    CGFloat textNumLabelY = textBackgroudView.bottom + kTextViewPadding;
    textNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, textNumLabelY, 100, 15)];
    textNumLabel.backgroundColor = [UIColor clearColor];
    textNumLabel.font = kBSDefaultFont;
    textNumLabel.textColor = [UIColor lightGrayColor];
    textNumLabel.textAlignment = NSTextAlignmentRight;
    textNumLabel.text = self.signatureString.length > 30 ?
    @"30/30" : [NSString stringWithFormat:@"%ld/30",(unsigned long)txtView.text.length];
    [textBackgroudView addSubview:textNumLabel];
    [scroll addSubview:textBackgroudView];
    [self.view addSubview:scroll];
    self.view.backgroundColor=kBackgroudColor;
}

#pragma mark - <Private Method>
-(void)backtohome
{
    if ([txtView.text length]>30 || [txtView.text containsEmoji]) {
        NSString *alertMessage = [txtView.text length] > 30 ? @"地址长度过长,请重新设置": @"地址暂不支持表情字符";
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:alertMessage];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView show];
        return;
    }
//    
//    if ([txtView.text containsEmoji]) {
//        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:@"地址暂不支持表情字符"];
//        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alertView show];
//        return;
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetSignature" object:txtView.text];
    if (_isBubbleChatCtl) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetSignatureToMore" object:txtView.text];
    }
    [self.delegate resetMessage:txtView.text Tag:self.tag];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <Delegate>
#pragma mark UITextViewDelegte
- (void)textViewDidChange:(UITextView *)textView {
    
    if (bIsThisView){
        NSInteger length = textView.text.length;
        textNumLabel.text = length > 30 ?
        @"30/30" :  [NSString stringWithFormat:@"%ld/30",(unsigned long)textView.text.length];
     }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (textView.text.length > 30) {
            textView.text = [textView.text substringWithRange:NSMakeRange(0, 30)];
        }
        return NO;
    }
    if ([text isEqualToString:@""]) {
        return YES;
    }
    int MAX_CHARS = 30;
    NSMutableString *newtxt = [NSMutableString stringWithString:textView.text];
    if (textView.text.length > 30) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 30)];
    }
    NSInteger length = newtxt.length;
    return (length < MAX_CHARS);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text.length >= 30) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 30)];
    }
    return YES;
}

@end
