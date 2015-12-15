//
//  BSBaseTableViewController.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSBaseTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//- (void)showNetworkIndicator;
//
//- (void)hideNetworkIndicator;
//
//- (void)showProgress;
//
//- (void)hideProgress;
//
//- (void)alert:(NSString *)msg;
//
//- (BOOL)alertError:(NSError *)error;
//
- (BOOL)filterError:(NSError *)error;
//
//- (void)runInMainQueue:(void (^)())queue;
//
//- (void)runInGlobalQueue:(void (^)())queue;
//
//- (void)runAfterSecs:(float)secs block:(void (^)())block;
//
//- (void)showHUDText:(NSString *)text;
//
//- (void)toast:(NSString *)text;
//
//- (void)toast:(NSString *)text duration:(NSTimeInterval)duration;


@end
