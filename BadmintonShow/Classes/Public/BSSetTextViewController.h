//
//  SetTextViewController.h
//  PAYZT
//
//  Created by 何广忠 on 14-6-3.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSSetTextViewControllerDelegate <NSObject>
- (void)resetMessage:(NSString *)message Tag:(int)tag;
@end

@interface BSSetTextViewController : UIViewController
@property (nonatomic, strong) NSString *signatureString;
@property (nonatomic, assign) BOOL isBubbleChatCtl;
@property (nonatomic, assign) int tag;
@property (nonatomic, weak) id <BSSetTextViewControllerDelegate> delegate;
@end
