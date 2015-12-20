//
//  BSBaseTableViewController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSBaseTableViewController.h"
#import "YYTableView.h"
#import "LeanChatLib.h"
#import "YYKit.h"

#define RGBCOLOR(r, g, b) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : 1]
#define  kTableViewBackgroudViewColor RGBCOLOR(240,240,240);

@interface BSBaseTableViewController ()
@end

@implementation BSBaseTableViewController

- (instancetype)init {
    self = [super init];
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.919];
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.frame = self.view.bounds;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.backgroundColor = kTableViewBackgroudViewColor ;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    if ( kSystemVersion < 7) {
        _tableView.top -= 64;
        _tableView.height += 20;
    }
}





#pragma mark - util

//-(void)alert:(NSString*)msg{
//    UIAlertView *alertView=[[UIAlertView alloc]
//                            initWithTitle:nil message:msg delegate:nil
//                            cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alertView show];
//}
//
//- (BOOL)alertError:(NSError *)error {
//    if (error) {
//        if (error.code == kAVIMErrorConnectionLost) {
//            [self alert:@"未能连接聊天服务"];
//        }
//        else if ([error.domain isEqualToString:NSURLErrorDomain]) {
//            [self alert:@"网络连接发生错误"];
//        }
//        else {
//#ifndef DEBUG
//            [self alert:[NSString stringWithFormat:@"%@", error]];
//#else
//            NSString *info = error.localizedDescription;
//            [self alert:info ? info : [NSString stringWithFormat:@"%@", error]];
//#endif
//        }
//        return YES;
//    }
//    return NO;
//}
//
//- (BOOL)filterError:(NSError *)error {
//    return [self alertError:error] == NO;
//}
//
//-(void)showNetworkIndicator{
//    UIApplication* app=[UIApplication sharedApplication];
//    app.networkActivityIndicatorVisible=YES;
//}
//
//-(void)hideNetworkIndicator{
//    UIApplication* app=[UIApplication sharedApplication];
//    app.networkActivityIndicatorVisible=NO;
//}
//
//-(void)showProgress{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//}
//
//-(void)hideProgress{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//}
//
//
//- (void)toast:(NSString *)text {
//    [self toast:text duration:2];
//}
//
//- (void)toast:(NSString *)text duration:(NSTimeInterval)duration {
//    MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    //    hud.labelText=text;
//    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
//    hud.detailsLabelText = text;
//    hud.margin=10.f;
//    hud.removeFromSuperViewOnHide=YES;
//    hud.mode=MBProgressHUDModeText;
//    [hud hide:YES afterDelay:duration];
//}
//
//-(void)showHUDText:(NSString*)text{
//    [self toast:text];
//}
//
//-(void)runInMainQueue:(void (^)())queue{
//    dispatch_async(dispatch_get_main_queue(), queue);
//}
//
//-(void)runInGlobalQueue:(void (^)())queue{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
//}
//
//-(void)runAfterSecs:(float)secs block:(void (^)())block{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs*NSEC_PER_SEC), dispatch_get_main_queue(), block);
//}


@end
