

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

+(void)testMethod{
    
    ZSMethodLearn *method = [[ZSMethodLearn alloc] init];
    
    [method getMethods];
    
}

-(void)getMethods{
    
    unsigned int  outCount =0;
    
    Method *methodList =  class_copyMethodList(self.class, &outCount);
    for (unsigned int i=0; i< outCount; ++i) {
        
        Method  method = methodList[i];
        SEL  methodName =method_getName(method);
        
        NSLog(@"方法名： %@", NSStringFromSelector(methodName));
        
    }
    
    
    
}

- (void)runtimeLog{

    NSLog(@" rumtime");
}
@end
