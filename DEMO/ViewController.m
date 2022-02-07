//
//  ViewController.m
//  DEMO
//
//  Created by 郭鹏 on 2021/11/28.
//  Copyright © 2021 郭鹏. All rights reserved.
//

#import "ViewController.h"
#import "GPChainedCalculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        GPChainedCalculator *mgr = [[GPChainedCalculator alloc] init];
    
        mgr.add(5).add(5).add(7).add(8);

}


@end
