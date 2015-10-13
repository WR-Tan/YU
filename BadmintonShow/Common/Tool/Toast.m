//
//  Toast.m
//  ColorScaner
//
//  Created by wihing on 12-10-21.
//  Copyright (c) 2012年 wihing. All rights reserved.
//

#import "Toast.h"
#import "UIKit+x.h"
#import <QuartzCore/QuartzCore.h>

@interface Toast ()

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation Toast

+ (Toast *)getInstance
{
    static Toast *toast;
    @synchronized ([Toast class]) {
        if (toast == nil) {
            toast = [UIView viewWithNib:@"Toast" owner:nil];
        }
    }
    return toast;
}

+ (void)toastWithMessage:(NSString *)message duration:(NSTimeInterval)interval
{
    Toast *toast = [Toast getInstance];
    [toast removeFromSuperview];
    toast.messageLabel.text = message;
    toast.frame = CGRectMake(100, 80, 120, 40);
    toast.alpha = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
    [UIView animateWithDuration:2 delay:interval options:UIViewAnimationOptionCurveEaseOut animations:^{
        toast.alpha = 0;
    } completion:^(BOOL finished) {
        [toast removeFromSuperview];
    }];
}



@end
