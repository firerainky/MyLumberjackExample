//
//  MyTest.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/8/8.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "MyTest.h"
#import "Logger.h"

@implementation MyTest

- (void)testLog {
    LogError(@"ggg", @"hahaha");
    LogDebug(@"not", @"toobad");
    
    [DDLog log:YES
       errCode:@"haha"
         level:ddLogLevel
          flag:LOG_FLAG_ERROR
       context:0
          file:__FILE__
      function:__FUNCTION__
          line:__LINE__
           tag:nil
        format:@"gggg"];
}

@end
