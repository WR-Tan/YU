//
//  XLView.h
//  TingShuo
//
//  Created by czh0766 on 12-8-21.
//
//

#import <UIKit/UIKit.h>

@protocol WWViewDelegate;

@interface WWView : UIView

@property (assign,nonatomic) id<WWViewDelegate> delegate;

@end

@protocol WWViewDelegate <NSObject>

@optional
-(void) viewWillMove:(UIView*)view toSuperview:(UIView *)superview;

-(void) viewDidMoveToSuperview:(UIView*)view;

-(void) viewWillMove:(UIView*)view toWindow:(UIWindow *)window;

-(void) viewDidMoveToWindow:(UIView*)view;

@end
