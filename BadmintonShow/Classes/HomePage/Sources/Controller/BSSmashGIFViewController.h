//
//  BSSmashGIFViewController.h
//  BadmintonShow
//
//  Created by LZH on 15/12/8.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSBaseViewController.h"

typedef NS_ENUM(NSInteger,  BSGIFSkillType){
    BSGIFSkillTypeFaQiu,   // 发球
    BSGIFSkillTypeKouQiu,  // 扣球
    BSGIFSkillTypeGaoYuanQiu, // 高远球
    BSGIFSkillTypeHuaBanQiu,  // 滑板球
    BSGIFSkillTypeStep,  // 步法
};

@interface BSSmashGIFViewController : BSBaseViewController

@end
