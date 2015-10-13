//
//  ProfileTool.h
//  Animating
//
//  Created by wisonlin on 13-7-23.
//  Copyright (c) 2013年 wisonlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileTool : NSObject

- (vm_size_t)getUsedMemory;
- (vm_size_t)getMaxMemory;
- (vm_size_t)getMinMemory;
- (float)cpu_usage;

@end
