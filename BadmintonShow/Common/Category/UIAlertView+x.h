//
//  UIAlertView+x.h
//  common
//
//  Created by czh0766 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (x)

+(id)messageBox:(NSString*)msg buttonTitle:(NSString*)title;

+(id)messageBox:(NSString*)msg buttonTitles:(NSArray*)titles delegate:(id)delegate;



@end



typedef void (^UIAlertViewBlock) (UIAlertView * __nonnull alertView);
typedef void (^UIAlertViewCompletionBlock) (UIAlertView * __nonnull alertView, NSInteger buttonIndex);

@interface UIAlertView (Blocks)

+ (nonnull instancetype)showWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                                style:(UIAlertViewStyle)style
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitles:(nullable NSArray *)otherButtonTitles
                             tapBlock:(nullable UIAlertViewCompletionBlock)tapBlock;

+ (nonnull instancetype)showWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitles:(nullable NSArray *)otherButtonTitles
                             tapBlock:(nullable UIAlertViewCompletionBlock)tapBlock;

@property (copy, nonatomic, nullable) UIAlertViewCompletionBlock tapBlock;
@property (copy, nonatomic, nullable) UIAlertViewCompletionBlock willDismissBlock;
@property (copy, nonatomic, nullable) UIAlertViewCompletionBlock didDismissBlock;

@property (copy, nonatomic, nullable) UIAlertViewBlock willPresentBlock;
@property (copy, nonatomic, nullable) UIAlertViewBlock didPresentBlock;
@property (copy, nonatomic, nullable) UIAlertViewBlock cancelBlock;

@property (copy, nonatomic, nullable) BOOL(^shouldEnableFirstOtherButtonBlock)(UIAlertView * __nonnull alertView);

@end