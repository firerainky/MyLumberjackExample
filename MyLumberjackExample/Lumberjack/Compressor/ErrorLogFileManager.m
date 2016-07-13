//
//  ErrorLogFileManager.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/8.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "ErrorLogFileManager.h"

@implementation ErrorLogFileManager

#pragma mark Log file name
// Override
- (BOOL)isLogFile:(NSString *)fileName {
    
    BOOL hasProperSuffix = [fileName hasSuffix:@".Error.log"];
    BOOL hasProperDate = NO;
    
    if (hasProperSuffix) {
        NSUInteger lengthOfMiddle = fileName.length - @".Error.log".length;
        
        // Date string should have 10 characters - "2013-12-03"
        if (lengthOfMiddle >= 10) {
            NSRange range = NSMakeRange(0, 10);
            
            NSString *dateString = [fileName substringWithRange:range];
            NSDateFormatter *dateFormatter = [self logFileDateFormatter];
                
            NSDate *date = [dateFormatter dateFromString:dateString];
            if (date) {
                hasProperDate = YES;
            }
        }
    }
    
    return (hasProperDate && hasProperSuffix);
}

// Override
- (NSString *)newLogFileName {

    NSDateFormatter *dateFormatter = [self logFileDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@.Error.log", formattedDate];
}

- (NSDateFormatter *)logFileDateFormatter {
    // Keep thread safety
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSString *dateFormat = @"yyyy-MM-dd";
    NSString *key = [NSString stringWithFormat:@"logFileDateFormatter.%@", dateFormat];
    NSDateFormatter *dateFormatter = dictionary[key];
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
        dictionary[key] = dateFormatter;
    }
    
    return dateFormatter;
}

@end
