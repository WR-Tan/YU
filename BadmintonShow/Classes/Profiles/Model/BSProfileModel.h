//
//  BSProfileModel.h
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSProfileModel : NSObject

@property (nonatomic, copy) NSString *imageName ;
@property (nonatomic, copy) NSString *name ;
@property (nonatomic, copy) NSString *detail ;
@property (nonatomic, copy) NSString *className ; // 点击Cell跳转的ViewController

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail;

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className;

- (instancetype)setImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className;


@end
