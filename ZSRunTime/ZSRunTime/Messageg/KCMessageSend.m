
//
//  KCMessageSend.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "KCMessageSend.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>
@implementation KCMessageSend

- (void)noArgumentAndNoReturnValue{
    NSLog(@"%s 没有参数没有返回值",__FUNCTION__);
}

-(void)hasArguments:(NSString*)arg{
    NSLog(@"%s 被调用  参数是: %@",__FUNCTION__,arg);
    
    
}

- (NSString*)noArgumentsButReturnValue{

    NSLog(@"%s is called  and the return value is %@",__FUNCTION__,@"不带参数但是有返回值");
    return @"不带参数，但是带有返回值";
    
}
-(int)hasArguments:(NSString*)arg andReturnValue:(int)arga1{
    NSLog(@"%s  was called ,arg is %@ ,and arg2 is %d",__FUNCTION__,arg,arga1);
    return arga1;
}


+(float)returnFloatType{
    NSLog(@"%s was called ,and has return value",__FUNCTION__);
    return 24.324839748922423;
}
// C函数
int cStyleFunc(id receiver,SEL sel,const void *arg1,const void *arg2){

    NSLog(@"%s was called ,arg1 is %@, and arg2 is %@",__FUNCTION__,[NSString stringWithUTF8String:arg1],[NSString stringWithUTF8String:arg2]);
    return 1;

}

+(void)test{
    
      // 1.创建对象
    KCMessageSend *msg =((KCMessageSend *(*)(id,SEL))objc_msgSend)((id)[KCMessageSend class],@selector(alloc));
     // 2.初始化对象
    
    msg =((KCMessageSend*(*)(id,SEL))objc_msgSend)((id)msg,@selector(init));
      // 3.调用无参数无返回值方法
    ((void(*)(id,SEL))objc_msgSend)((id)msg,@selector(noArgumentAndNoReturnValue));
      // 4.调用带一个参数但无返回值的方法
    
    ((void(*)(id,SEL,NSString*))objc_msgSend)((id)msg,@selector(hasArguments:),@"一个参数");
    
      // 5.调用带返回值，但是不带参数
    NSString *returnValue =((NSString *(*)(id,SEL))objc_msgSend)((id)msg,@selector(noArgumentsButReturnValue));
    
    NSLog(@"返回值是 -- %@",returnValue);
      // 6.带参数带返回值
    int reValue =((int(*)(id,SEL,NSString*,int))objc_msgSend)(msg,@selector(hasArguments:andReturnValue:),@"kakaotalk",1000);
    
    NSLog(@"6 返回值是: %d",reValue);
    NSLog(@"%s",@encode(const void *));
    
     // 7.动态添加方法，然后调用C函数
    class_addMethod(msg.class, NSSelectorFromString(@"cStyleFunc"), (IMP)cStyleFunc, "i@:r^vr^v");
    reValue = ((int(*)(id,SEL,const void* ,const void*))objc_msgSend)((id)msg ,NSSelectorFromString(@"cStyleFunc"),"动态","方法");
      NSLog(@"7. return value is %d", reValue);
     // 8.返回浮点型时，调用objc_msgSend/objc_msgSend_fpret,其结果是一样的。
}
@end
