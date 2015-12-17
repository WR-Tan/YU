//
//  BSProfileModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileModel.h"


@implementation BSProfileModel

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className{
    BSProfileModel *model = [[BSProfileModel alloc] init];
    model.imageName = imageName;
    model.title = title;
    model.detail = detail;
    model.className = className;
    return model;
}

- (instancetype)setImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className{
    self.imageName = imageName;
    self.title = title;
    self.detail = detail;
    self.className = className;
    return self;
}

@end
