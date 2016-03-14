//
//  KCArchive.h
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import ""
@interface KCArchive : NSObject

@property (nonatomic, assign) int    referenceCount;
//@property (nonatomic, strong) HYBTestModel *testModel;
@property (nonatomic, copy) NSString *archive;
@property (nonatomic, assign) const void *session;
@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, assign) float  _floatValue;

+(void)test;
@end
