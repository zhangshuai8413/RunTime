

//
//  ZSMethodLearn.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "ZSMethodLearn.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation ZSMethodLearn

- (int)instanceMehod:(NSString*)name andValue:(NSNumber *)value {

    NSLog(@"name:%@",name);
    return value.intValue;
    
}
+(void)testMethod{
    
    ZSMethodLearn *method = [[ZSMethodLearn alloc] init];
    
//    [method getMethods];
    ((void(*)(id,SEL))objc_msgSend)((id)method,@selector(getMethods));
     // 这就是为什么有四个参数的原因
    
    int returnValue  = ((int(*)(id,SEL,NSString*,NSNumber*))objc_msgSend)((id)method,@selector(instanceMehod:andValue:),@"张帅",@100);
    
    NSLog(@"return value is  %d",returnValue);
    
      // 获取方法
    
    Method mthod = class_getInstanceMethod([self class],@selector(instanceMehod:andValue:));
    returnValue  =((int (*)(id,Method , NSString * ,NSNumber *))method_invoke)((id)method,mthod,@"method_invoke 测试",@22);
     NSLog(@"call return value is %d",returnValue);
    
}

-(void)getMethods{
    
    unsigned int  outCount =0;
    
    Method *methodList =  class_copyMethodList(self.class, &outCount);
    for (unsigned int i=0; i< outCount; ++i) {
        Method  method = methodList[i];
        SEL  methodName =method_getName(method);
        NSLog(@"MethodName： %@", NSStringFromSelector(methodName));
        //get type of Method
        unsigned int argumetsCount =method_getNumberOfArguments(method);
        
        char argName[512] ={};
        for (unsigned int j=0; j< argumetsCount; ++j) {
            method_getArgumentType(method, j, argName, 512);
            NSLog(@"第%u 个参数类型为 %s",j,argName);
            memset(argName, '\0', strlen(argName));
        }
    
        
        char returnType[512] ={};
        
        method_getReturnType(method, returnType, 512);
        NSLog(@"返回值类型:%s",returnType);
        
        //TYPE encodingtestMethod
        NSLog(@"TypeEncoding:%s",method_getTypeEncoding(method));
        
    }
    
    free(methodList);
    
}

- (void)runtimeLog{

    NSLog(@" rumtime");
}

- (NSArray*)getArrayWithdNames:(NSArray *)name{
    NSLog(@"name %@",name);
    return name;
    
}
@end
