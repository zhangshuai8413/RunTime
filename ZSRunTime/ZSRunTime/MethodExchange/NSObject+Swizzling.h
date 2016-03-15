//
//  NSObject+Swizzling.h
//  ZSRunTime
//
//  Created by kakao on 16/3/15.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end
