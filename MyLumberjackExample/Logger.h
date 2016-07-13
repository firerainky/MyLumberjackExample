//
//  Logger.h
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/5.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#ifndef Logger_h
#define Logger_h

#define LOG_LEVEL_DEF ddLogLevel
#import "ZhaohuLog.h"


#ifdef DEBUG
    static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
    static DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#endif /* Logger_h */
