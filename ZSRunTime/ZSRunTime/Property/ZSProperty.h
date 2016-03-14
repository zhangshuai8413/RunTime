//
//  ZSProperty.h
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSProperty : NSObject
{
    int _number;
    @private
    float _private;
    
}


@property(nonatomic,copy) NSString* title;
@property(nonatomic,strong) NSArray *names;
@property(nonatomic,assign) int count;
@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) NSNumber *atomicProperty;

+ (void)test;

@end
