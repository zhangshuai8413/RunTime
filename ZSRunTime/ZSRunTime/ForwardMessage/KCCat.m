

//
//  KCCat.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "KCCat.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "KCDog.h"
#import "KCPig.h"
@implementation KCCat
// 第一步：在没有找到方法时，会先调用此方法，可用于动态添加方法
// 我们不动态添加

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
}

// 第二步：上一步返回NO，就会进入这一步，用于指定备选响应此SEL的对象
// 千万不能返回self，否则就会死循环
// 自己没有实现这个方法才会进入这一流程，因此成为死循环
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return nil;
}

// 第三步：指定方法签名，若返回nil，则不会进入下一步，而是无法处理消息

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"eat"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        
    }
    return [super methodSignatureForSelector:aSelector];
}

// 当我们实现了此方法后，-doesNotRecognizeSelector:不会再被调用
// 如果要测试找不到方法，可以注释掉这一个方法
-(void)forwardInvocation:(NSInvocation *)anInvocation{
  // 我们还可以改变方法选择器
    [anInvocation setSelector:@selector(jump)];
    // 改变方法选择器后，还需要指定是哪个对象的方法
    [anInvocation invokeWithTarget:self];
}

-(void)jump{
    NSLog(@"eat 方法没，现在执行jump 方法");
    
}

//forwardInvocation:(NSInvocation *)anInvocation 没有实现就执行下面的代码

//-(void)doesNotRecognizeSelector:(SEL)aSelector{
//
//    NSLog(@"无法处理消息 %@",NSStringFromSelector(aSelector));
//    
//}
+(void)test{

//    KCCat *cat =[[KCCat alloc] init];
//    [cat performSelector:@selector(eat) withObject:nil afterDelay:0];
//    
//     KCDog *dog=[[KCDog alloc] init];
//    [dog eat];
    KCPig  *pig =[[KCPig alloc] init];
    ((void(*)(id,SEL))objc_msgSend)((id)pig,@selector(eat));
    
}

//void eat (id self ,SEL cmd){
//    NSLog(@"%@ is eating",self);
//    
//}
@end
