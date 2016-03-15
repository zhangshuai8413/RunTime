//
//  NSArray+Swizzling.m
//  ZSRunTime
//
//  Created by kakao on 16/3/15.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzling)

-(id)swi_lastObject{
    if (self.count==0) {
        NSLog(@"%s 数组为空，直接返回nill",__FUNCTION__);
        return nil;
    }
    return [self swi_lastObject];
}
@end
