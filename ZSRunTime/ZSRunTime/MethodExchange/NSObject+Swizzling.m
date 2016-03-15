//
//  NSObject+Swizzling.m
//  ZSRunTime
//
//  Created by kakao on 16/3/15.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzling)

+(void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector{
    Class  class =[self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod  = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =class_addMethod(class ,originalSelector,method_getImplementation(swizzledMethod) , method_getTypeEncoding(swizzledMethod));
    // 若原来的方法并不存在，则添加即可
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
    
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
