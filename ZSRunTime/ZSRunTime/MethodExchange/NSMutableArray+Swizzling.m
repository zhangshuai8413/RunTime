
//
//  NSMutableArray+Swizzling.m
//  ZSRunTime
//
//  Created by kakao on 16/3/15.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
@implementation NSMutableArray (Swizzling)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(removeObject:) withSwizzledSelector:@selector(swi_safeRemoveObject:)];
        
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(addObject:) withSwizzledSelector:@selector(swi_safeAddObject:)];
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(swi_safeRemoveObjectAtIndex:) ];
        
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(swi_insertObject:atIndex:)];
        
//        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(swi_initWithObject:count:)];
//
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(hdf_initWithObjects:count:)];
        
        
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(swi_objectAtIndex:)];
    });

}

- (instancetype)hdf_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"objects[i] %@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            NSLog(@"%s object at index %lu is nil, it will be filtered", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        
        NSLog(@"%@", [NSThread callStackSymbols]);
        return [self hdf_initWithObjects:newObjects count:index];
    }
    
    return [self hdf_initWithObjects:objects count:cnt];
}

-(id)swi_objectAtIndex:(NSInteger )index{
    if (self.count==0) {
        NSLog(@"%s can't get any object form empty array",__FUNCTION__);
        return nil;
    }
    if (index> self.count) {
        NSLog(@"%s index out of bounds in array ",__FUNCTION__);
        return nil;
    }
   return  [self swi_objectAtIndex:index];
}

-(instancetype)swi_initWithObject:(const id _Nonnull __unsafe_unretained *)objects count:(NSInteger)count{
    BOOL hasNilObject =NO;
    for (NSUInteger i=0; i< count; ++i) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@",objects[i]);
        }
        if (objects[i]==nil) {
            hasNilObject =YES;
            NSLog(@"%s obect at index %lu is nill ,it will be filtered",__FUNCTION__,i);
      }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained  newObjects[count];
    NSInteger index =0;
    for (int i=0; i< count; ++i) {
        if (objects[i]!=nil) {
            newObjects[index++]=objects[i];
      }
    }
    NSLog(@"callStackSymbols %@ ",[NSThread callStackSymbols]);
    return [self swi_initWithObject:newObjects count:count];
    }
    
    return [self swi_initWithObject:objects count:count];
}


- (void)swi_insertObject:(id)anObject atIndex:(NSUInteger)index{

    if (anObject==nil) {
        NSLog(@"%s can,t insert nill  into NSMutableArray ",__FUNCTION__);
    }else if (index>self.count){
        NSLog(@"%s index is invalid ",__FUNCTION__);
    }else{
        [self swi_insertObject:anObject atIndex:index];
    }
}

-(void)swi_safeRemoveObjectAtIndex:(NSInteger)index {
    if (self.count<=0) {
        NSLog(@"%s cant get any object from an empty array",__FUNCTION__);
        return;
    }
    if(index>= self.count){
        NSLog(@"%s index out of bound ",__FUNCTION__);
        return;
    }
    [self swi_safeRemoveObjectAtIndex:index];
}

-(void)swi_safeAddObject:(id)obj{

    if (obj==nil) {
        NSLog(@"%s can add nil object into NSMutableArray",__FUNCTION__);
    }else{
        [self swi_safeAddObject:obj];
    }
}

-(void)swi_safeRemoveObject:(id)obj{
    if (obj==nil) {
        NSLog(@"%s call --removeObeject but obj is nill",__FUNCTION__);
        return;
    }
    [self swi_safeRemoveObject:obj];
}
@end
