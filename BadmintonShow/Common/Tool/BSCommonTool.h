//
//  BSCommonTool.h
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^sender_block)(id sender);

@interface BSCommonTool : NSObject


+ (UIBarButtonItem *)createRightBarButtonItem:(NSString *)title target:(id)obj selector:(SEL)selector ImageName:(NSString*)imageName ;

+ (UIButton *)bottomButtomWithVC:(UIViewController *)VC ;

    
@end
