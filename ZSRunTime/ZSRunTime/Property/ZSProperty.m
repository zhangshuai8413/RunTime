
//
//  ZSProperty.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "ZSProperty.h"
#import <objc/runtime.h>
@implementation ZSProperty



- (void)getAllProperties{

    unsigned int  outCount = 0;
    //Ivar
    objc_property_t *properties= class_copyPropertyList(self.class, &outCount);
    for (unsigned int i=0; i< outCount; ++i) {
        objc_property_t  property =properties[i];
        const char  *propertyName =property_getName(property);
        const char *propertyAttributes =property_getAttributes(property);
        NSLog(@"propertyName %s propertyAttributes: %s ",propertyName,propertyAttributes );
        unsigned int  count=0;
        objc_property_attribute_t  *attrbutes  =property_copyAttributeList(property, &count);
        for ( unsigned int j=0; j< count; ++j) {
            
            objc_property_attribute_t attribute = attrbutes[j];
            const char *name = attribute.name;
            const char *value =attribute.value;
            NSLog(@"name: %s   value: %s", name, value);
            
        }
        free(attrbutes);
    }
    free(properties);
}

-(void)getAllMemberVariables{
    unsigned int  outCount  =0;
    Ivar *ivars =class_copyIvarList(self.class, &outCount);
    
    for (unsigned int i=0; i< outCount; ++i) {
        Ivar ivar = ivars[i];
        const char  *name =ivar_getName(ivar);
        const char  *type =ivar_getTypeEncoding(ivar);
        NSLog(@"name : %s encodeType:%s",name,type);
        
    }
    free(ivars);
    
}



+(void)test{

    ZSProperty  *pro =[[ZSProperty alloc] init];
     [pro getAllProperties];
    [ pro getAllMemberVariables];
}
@end
