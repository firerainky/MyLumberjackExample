//
//  ZhaohuLog.h
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/7.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "CocoaLumberjack.h"

// We want to use the following log levels:
//
// Fatal
// Error
// Warn
// Info
// Debug
//
// All we have to do is undefine the default values,
// and then simply define our own however we want.

// First undefine the default stuff we don't want to use.

#undef LOG_FLAG_ERROR
#undef LOG_FLAG_WARN
#undef LOG_FLAG_INFO
#undef LOG_FLAG_DEBUG
#undef LOG_FLAG_VERBOSE

#undef LOG_LEVEL_ERROR
#undef LOG_LEVEL_WARN
#undef LOG_LEVEL_INFO
#undef LOG_LEVEL_DEBUG
#undef LOG_LEVEL_VERBOSE

#undef LOG_ERROR
#undef LOG_WARN
#undef LOG_INFO
#undef LOG_DEBUG
#undef LOG_VERBOSE

#undef DDLogError
#undef DDLogWarn
#undef DDLogInfo
#undef DDLogDebug
#undef DDLogVerbose

//#undef DDLogCError
//#undef DDLogCWarn
//#undef DDLogCInfo
//#undef DDLogCDebug
//#undef DDLogCVerbose

// Now define everything how we want it

#define LOG_FLAG_FATAL   (1 << 0)  // 0...000001
#define LOG_FLAG_ERROR   (1 << 1)  // 0...000010
#define LOG_FLAG_WARN    (1 << 2)  // 0...000100
#define LOG_FLAG_INFO    (1 << 3)  // 0...001000
#define LOG_FLAG_DEBUG   (1 << 4)  // 0...010000

#define LOG_LEVEL_FATAL   (LOG_FLAG_FATAL)                     // 0...000001
#define LOG_LEVEL_ERROR   (LOG_FLAG_ERROR  | LOG_LEVEL_FATAL ) // 0...000011
#define LOG_LEVEL_WARN    (LOG_FLAG_WARN   | LOG_LEVEL_ERROR ) // 0...000111
#define LOG_LEVEL_INFO    (LOG_FLAG_INFO   | LOG_LEVEL_WARN  ) // 0...001111
#define LOG_LEVEL_DEBUG   (LOG_FLAG_DEBUG  | LOG_LEVEL_INFO  ) // 0...011111

#define LOG_FATAL   (ddLogLevel & LOG_FLAG_FATAL )
#define LOG_ERROR   (ddLogLevel & LOG_FLAG_ERROR )
#define LOG_WARN    (ddLogLevel & LOG_FLAG_WARN  )
#define LOG_INFO    (ddLogLevel & LOG_FLAG_INFO  )
#define LOG_DEBUG   (ddLogLevel & LOG_FLAG_DEBUG )

#define DDLogFatal(frmt, ...)   LOG_MAYBE(NO,  ddLogLevel, LOG_FLAG_FATAL,  0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define DDLogError(frmt, ...)   LOG_MAYBE(NO,  ddLogLevel, LOG_FLAG_ERROR,  0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define DDLogWarn(frmt, ...)    LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_WARN,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define DDLogInfo(frmt, ...)    LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_INFO,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define DDLogDebug(frmt, ...)   LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_DEBUG,  0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

#define LogFatal(errcode, frmt, ...)    LOG_SHOULDBE(NO,  errcode, ddLogLevel, LOG_FLAG_FATAL,  0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LogError(errcode, frmt, ...)    LOG_SHOULDBE(NO,  errcode, ddLogLevel, LOG_FLAG_ERROR,  0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LogWarn(errcode, frmt, ...)     LOG_SHOULDBE(YES, errcode, ddLogLevel, LOG_FLAG_WARN,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LogInfo(errcode, frmt, ...)     LOG_SHOULDBE(YES, errcode, ddLogLevel, LOG_FLAG_INFO,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LogDebug(errcode, frmt, ...)    LOG_SHOULDBE(YES, errcode, ddLogLevel, LOG_FLAG_DEBUG,  0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

//#define DDLogCFatal(frmt, ...)  LOG_MAYBE(ddLogLevel, LOG_FLAG_FATAL,  0, frmt, ##__VA_ARGS__)
//#define DDLogCError(frmt, ...)  LOG_MAYBE(ddLogLevel, LOG_FLAG_ERROR,  0, frmt, ##__VA_ARGS__)
//#define DDLogCWarn(frmt, ...)   LOG_MAYBE(ddLogLevel, LOG_FLAG_WARN,   0, frmt, ##__VA_ARGS__)
//#define DDLogCInfo(frmt, ...)   LOG_MAYBE(ddLogLevel, LOG_FLAG_INFO,   0, frmt, ##__VA_ARGS__)
//#define DDLogCDebug(frmt, ...)  LOG_MAYBE(ddLogLevel, LOG_FLAG_DEBUG,  0, frmt, ##__VA_ARGS__)

