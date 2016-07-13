//
//  MyCustomFormatter.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/7.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "MyCustomFormatter.h"

@implementation MyCustomFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    NSDateFormatter *dateFormatter = [self logLineDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:logMessage.timestamp];
    NSString *logLevel;
    switch (logMessage.flag) {
        case LOG_FLAG_FATAL:
            logLevel = @"Fatal";
            break;
        case LOG_FLAG_ERROR:
            logLevel = @"Error";
            break;
        case LOG_FLAG_WARN:
            logLevel = @"Warn";
            break;
        case LOG_FLAG_INFO:
            logLevel = @"Info";
            break;
        case LOG_FLAG_DEBUG:
            logLevel = @"Debug";
            break;
        default:
            logLevel = @"Unknown";
            break;
    }
    
    NSString *logLine = [NSString stringWithFormat:@"[%@][%@][%@][%@][%@][%@][%@] %@",
                         formattedDate,
                         logLevel,
                         logMessage.function,
                         logMessage.errCode,
                         logMessage.threadID,
                         logMessage.threadName,
                         logMessage.queueLabel,
                         logMessage.message];
    
    
    return [NSString stringWithFormat:@"%@", logLine];
}

- (NSDateFormatter *)logLineDateFormatter {
    // Keep thread safety
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    NSString *key = [NSString stringWithFormat:@"logLineDateFormatter.%@", dateFormat];
    NSDateFormatter *dateFormatter = dictionary[key];
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
        dictionary[key] = dateFormatter;
    }
    
    return dateFormatter;
}

@end
