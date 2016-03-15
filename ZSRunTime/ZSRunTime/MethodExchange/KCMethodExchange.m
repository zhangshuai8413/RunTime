//
//  KCMethodExchange.m
//  ZSRunTime
//
//  Created by kakao on 16/3/15.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "KCMethodExchange.h"
#import <objc/runtime.h>
#import "NSArray+Swizzling.h"
@implementation KCMethodExchange

+(void)test{
//    Method   originalMethod  =class_getInstanceMethod([NSArray class], @selector(lastObject));
//    Method  newMethod =class_getInstanceMethod([NSArray class], NSSelectorFromString(@"swi_lastObject"));
//    method_exchangeImplementations(originalMethod, newMethod);
//
//      NSMutableArray *array = [@[@"value" ] mutableCopy];
////      [array lastObject];
//    
//      [array removeObject:@"value"];
//      [array removeObject:nil];
//      [array addObject:@"12"];
//      [array addObject:nil];
//      [array removeObjectAtIndex:101];
//     [array insertObject:@32 atIndex:23];
//    NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
//    [anotherArray objectAtIndex:0];
//    
    NSString *nilStr = nil;
    
    NSArray *array1 = @[@"343", @"keyide", @"shibushi", nilStr];
//    NSLog(@"array1.count = %lu", array1.count);
    ////  // 测试数组中有数组
      NSArray *array2 = @[@[@"12323", @"nsdf", nilStr], @[@"sdf", @"nilsdf", nilStr, @"sdhfodf"]];
}
@end
