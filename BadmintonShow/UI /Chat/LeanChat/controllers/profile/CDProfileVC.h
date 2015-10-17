//
//  CDProfileController.h
//  LeanChat
//
//  Created by Qihe Bian on 7/28/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "MCMutipleSectionTC.h"

@interface CDProfileVC : MCMutipleSectionTC

/** 调用这个，下次 SNS 登录的时候会重新去第三方应用请求，而不会用本地缓存 */
- (void)deleteAuthDataCache;

@end
