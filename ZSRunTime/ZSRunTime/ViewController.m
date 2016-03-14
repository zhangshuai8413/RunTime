//
//  ViewController.m
//  ZSRunTime
//
//  Created by kakao on 16/3/14.
//  Copyright © 2016年 shuai zhang. All rights reserved.
//

#import "ViewController.h"
#import "ZSMethodLearn.h"
#import "ZSProperty.h"
#import "KCCat.h"
#import "KCMessageSend.h"
#import "IMPViewVC.h"
#import "KCArchive.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)impClick:(id)sender {
    
    IMPViewVC  *vc =[IMPViewVC new];
    
    vc.view.backgroundColor=[UIColor redColor];
    
  [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [ZSMethodLearn testMethod];
//    [ZSProperty test];
    
//    [KCCat test];
//      [KCMessageSend test];
    [KCArchive test];
}

@end
