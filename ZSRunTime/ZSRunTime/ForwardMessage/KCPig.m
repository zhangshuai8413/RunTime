
//
//  KCPig.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "KCPig.h"
#import "KCDog.h"
@implementation KCPig
// 第一步，我们不动态添加方法，返回NO
+(BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
}

// 第二步，备选提供响应aSelector的对象，我们不备选，因此设置为nil，就会进入第三步
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return nil;
}
// 第三步，先返回方法选择器。如果返回nil，则表示无法处理消息
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"eat"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        
    }
    return [super methodSignatureForSelector:aSelector];
}
// 第三步，只有返回了方法签名，都会进入这一步，这一步用户调用方法
// 改变调用对象等

-(void)forwardInvocation:(NSInvocation *)anInvocation{
  // 我们改变调用对象为dog
    [anInvocation invokeWithTarget:[[KCDog alloc] init]];
}
@end
