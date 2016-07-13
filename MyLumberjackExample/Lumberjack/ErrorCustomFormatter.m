//
//  ErrorCustomFormatter.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/8.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "ErrorCustomFormatter.h"

@implementation ErrorCustomFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    if (logMessage.flag != LOG_FLAG_ERROR) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [self logLineDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:logMessage.timestamp];
    
    NSString *logLine = [NSString stringWithFormat:@"[%@][Error][%@][%@][%@][%@][%@] %@",
                         formattedDate,
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
