//
//  CustomModalView.h
//  PANewToapAPP
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PAFFCustomModalViewDelegate ;
@class PAFFApplyCreditCardNormalEditCell;

@interface PAFFCustomModalView : UIView
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic ,copy)  NSString *backString;
@property (nonatomic ,copy)  NSString *callBackMethod;

@property (nonatomic ,strong) UITableView *HouseInfoTableView;
@property (nonatomic ,strong) UITableView *CarInfoTableView;
@property (nonatomic ,strong) UITableView *MoreTableView;
@property (nonatomic ,strong) PAFFApplyCreditCardNormalEditCell *cell;
@property (nonatomic ,strong) UITableViewCell *tableViewCell;

@property (nonatomic, weak) id <PAFFCustomModalViewDelegate> delegate ;

-(void)fetchBackString;

-(void)show;

-(void)dismiss;

-(void)done:(id)sender;

@end


@protocol PAFFCustomModalViewDelegate <NSObject>

@optional

- (void)customModalView:(PAFFCustomModalView *)custom  selectString:(NSString *)selectString;

-(void)done:(id)sender;
@end
