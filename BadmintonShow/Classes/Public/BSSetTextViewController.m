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
#import "BSProfileBusiness.h"
#import "SVProgressHUD.h"

#define kMaxLenth 30

#define kTextViewPadding  10
#define kTextViewHeight   140

@interface BSSetTextViewController  () <UITextViewDelegate, UIAlertViewDelegate, UITableViewDelegate> {
    UITextView *txtView;
    BOOL isFirst;
    UILabel *textNumLabel;
    BOOL bIsThisView;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BSSetTextViewController 

#pragma mark - <Life Cycle>

- (instancetype)init{
    self = [super init];
    if (self) {
        _limitCount = 30;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    bIsThisView = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    bIsThisView = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    bIsThisView = NO;
    self.view.backgroundColor = kBackgroudColor;
    self.navigationItem.rightBarButtonItem = [BSCommonTool createRightBarButtonItem:@"保存" target:self selector:@selector(backtohome) ImageName:@""];
    isFirst = YES;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    
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
    
   
    
    // 提示语
    UITextView *feedBackTip = [UITextView new];
    feedBackTip.frame = CGRectMake(10, 10, kScreenWidth - 20, 20);
    feedBackTip.textColor = [UIColor blackColor];
    feedBackTip.text = self.tipText ;
    feedBackTip.font = kBSFontSize(14);
    CGSize size = [feedBackTip sizeThatFits:CGSizeMake(kScreenWidth - 20, 100)];
    feedBackTip.frame = (CGRect){{10,10}, {size.width, size.height}};
    [self.tableView addSubview:feedBackTip];
    
    //  输入框背景View
    UIView *textBackgroudView = [UIView new];
    textBackgroudView.backgroundColor = [UIColor whiteColor];
    textBackgroudView.frame = CGRectMake(0, feedBackTip.bottom + 10, kScreenWidth, txtView.frame.size.height);
    [textBackgroudView addSubview:txtView];
    
    
    CGFloat textNumLabelY = textBackgroudView.bottom + kTextViewPadding;
    textNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, textNumLabelY, 100, 15)];
    textNumLabel.backgroundColor = [UIColor clearColor];
    textNumLabel.font = kBSDefaultFont;
    textNumLabel.textColor = [UIColor lightGrayColor];
    textNumLabel.textAlignment = NSTextAlignmentRight;
    textNumLabel.text = [NSString stringWithFormat:@"%ld/%d",(unsigned long)txtView.text.length, self.limitCount];
    [self.tableView addSubview:textNumLabel];
    [self.tableView addSubview:textBackgroudView];
    
    self.view.backgroundColor=kBackgroudColor;
}

#pragma mark - <Private Method>
-(void)backtohome
{
    [self.view endEditing:YES];
    // || [txtView.text containsEmoji]
    if ([txtView.text length]> self.limitCount ) {
        NSString *alertMessage = [txtView.text length] > self.limitCount ? @"文字超过30个,请重新设置": @"暂不支持表情字符";
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:alertMessage];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
        return;
    }
    
    [self.delegate resetMessage:(txtView.text?:@"") Tag:self.tag];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - <Delegate>
#pragma mark UITextViewDelegte
- (void)textViewDidChange:(UITextView *)textView {
    
    if (bIsThisView){
        textNumLabel.text =
        [NSString stringWithFormat:@"%ld/%d",(unsigned long)textView.text.length,self.limitCount];
     }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (textView.text.length > self.limitCount) {
            textView.text = [textView.text substringWithRange:NSMakeRange(0, self.limitCount)];
        }
        return NO;
    }
    if ([text isEqualToString:@""]) {
        return YES;
    }
    int MAX_CHARS = self.limitCount;
    NSMutableString *newtxt = [NSMutableString stringWithString:textView.text];
    if (textView.text.length > self.limitCount) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, self.limitCount)];
    }
    NSInteger length = newtxt.length;
    return (length < MAX_CHARS);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text.length >= self.limitCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.limitCount)];
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


@end
