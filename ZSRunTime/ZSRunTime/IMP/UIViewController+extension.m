//
//  UIViewController+extension.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

//修改的方法有返回值就用IMP，无返回值就用VIMP
typedef id   (*_IMP)  (id,SEL,...);
typedef void (*_VIMP) (id,SEL,...);
#import <objc/runtime.h>
#import "UIViewController+extension.h"

@implementation UIViewController (extension)

+ (void)load
{
    //保证交换方法只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //获取原始方法
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        
        //获取方法实现
        _VIMP viewWillAppear_IMP = (_VIMP)method_getImplementation(viewWillAppear);
        
        //重新设置方法实现
        method_setImplementation(viewWillAppear,imp_implementationWithBlock(^(id target,SEL action){
            viewWillAppear_IMP(target,@selector(viewWillAppear:));
            
            NSString  * viewName  =(NSString*)target;
            NSString *vcName =[NSString stringWithFormat:@"%@",viewName.class];
            NSLog(@"vcName  %@",vcName);
            
        }));
    });
}


@end
