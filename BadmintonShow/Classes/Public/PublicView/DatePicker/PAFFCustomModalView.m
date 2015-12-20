//
//  CustomModalView.m
//  PANewToapAPP
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import "PAFFCustomModalView.h"
#import "PAFFApplyCreditCardNormalEditCell.h"

@implementation PAFFCustomModalView
{
    UIView * titleView;
}
@synthesize overlayView;
@synthesize titleLabel;
@synthesize delegate;
@synthesize backString;
@synthesize callBackMethod;
-(id)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        self.userInteractionEnabled = YES;
        self.overlayView =[[UIView alloc] initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.backgroundColor =[UIColor whiteColor];
        
        //添加浮层
        self.overlayView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.overlayView.userInteractionEnabled = YES;
        self.overlayView.tag = 7519;
        overlayView.backgroundColor = [UIColor colorWithRed:109/255.f green:109/255.f blue:109/255.f alpha:0.f];
        
        UIWindow * currentwindow = [[UIApplication sharedApplication].windows lastObject];
        // 调试RTCRedBoxWindow，dismiss会hidden=YES ;  应该改为hidden=NO;
        currentwindow.hidden = NO ;
        [currentwindow addSubview:self.overlayView];
        [overlayView addSubview:self];
        
        
        //手势区域
        UIView * gapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height - 216 - 44)];
        gapView.userInteractionEnabled = YES ;
        gapView.backgroundColor = [UIColor clearColor];
        [gapView addGestureRecognizer:tap];
        [overlayView addSubview:gapView];
        
        titleView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 44)];
        titleView.backgroundColor = RGB(69, 69, 69);
        titleView.alpha = 1.f;
        [self.overlayView addSubview:titleView];
        
        UIButton * doneBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setFrame:CGRectMake(kScreenWidth - 80, 0, 80, 44)];
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [doneBtn.titleLabel setFont:kBSFontSize(15)];
        [doneBtn setTitleColor:RGB(0, 136, 255) forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:doneBtn];
        
        //标题
        self.titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        [self.titleLabel setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 22)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = kBSFontSize(15);
        self.titleLabel.backgroundColor =[UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [titleView addSubview:self.titleLabel];
    }
    
    return self;
}


-(IBAction)tap:(id)sender
{
    [self dismiss];
}

//设置返回的数据
-(void)fetchBackString{
    
}

-(void)show{
    CGRect rect = self.frame;
    [UIView animateWithDuration:0.3 animations:^{
        [titleView setFrame:CGRectMake(0, kScreenHeight - 216 - 44, kScreenWidth, 44)];
        [self setFrame:CGRectOffset(rect, 0, -rect.size.height)];
        //        overlayView.backgroundColor =[UIColor colorWithRed:109/255.f green:109/255.f blue:109/255.f alpha:0.8f];
        overlayView.backgroundColor =[UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.4f];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss{
    CGRect rect = self.frame;
    [UIView animateWithDuration:0.3 animations:^{
        [titleView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 44)];
        [self setFrame:CGRectOffset(rect , 0 , rect.size.height)];
        overlayView.backgroundColor =[UIColor colorWithRed:109/255.f green:109/255.f blue:109/255.f alpha:0.0f];
        
        
    } completion:^(BOOL finished) {
        [overlayView removeFromSuperview];
        self.overlayView= nil;
    }];
    
}


-(void)done:(id)sender
{
    [self fetchBackString];
    
    if(self.cell)
    {
        self.cell.lastLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"DATE_REGISTER_CAR"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"DATE_REGISTER_CAR"]);
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DATE_REGISTER_CAR"];
    }
    else if(self.tableViewCell) {
        self.tableViewCell.detailTextLabel.textColor = RGB(0, 135, 255);
        self.tableViewCell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"DATE_PURCHASE_DATE"];
        //        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DATE_PURCHASE_DATE"];
    }
    
    if ([delegate respondsToSelector:@selector(customModalView:selectString:)]) {
        [delegate customModalView:self selectString:self.backString];
    }
    
    [self dismiss];
}

@end
