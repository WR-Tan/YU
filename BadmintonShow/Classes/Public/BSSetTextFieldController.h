//
//  BSSetTextFieldController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSSetTextFieldControllerDelegate <NSObject>
- (void)resetText:(NSString *)text Tag:(int)tag ;
@end


@interface BSSetTextFieldController : UIViewController
@property (nonatomic, assign) int tag ;
@property (nonatomic, assign) int limitCount ;
@property (nonatomic, copy) NSString *originalText ;
@property (nonatomic, weak) id <BSSetTextFieldControllerDelegate> delegate;
@property (nonatomic, copy) NSString *placeholder;
@end
