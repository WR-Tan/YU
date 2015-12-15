//
//  BSProfileModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileModel.h"


@implementation BSProfileModel

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail{
    BSProfileModel *model = [[BSProfileModel alloc] init];
    model.imageName = imageName;
    model.name = title;
    model.detail = detail;
    return model;
}

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className{
    BSProfileModel *model = [BSProfileModel modelWithImageName:imageName title:title detail:detail];
    model.className = className;
    return model;
}

- (instancetype)setImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className{
    self.imageName = imageName;
    self.name = title;
    self.detail = detail;
    self.className = className;
    return self;
}

@end
