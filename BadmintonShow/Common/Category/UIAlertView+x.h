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
