//
//  ViewController.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/5.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "ViewController.h"
#import "Logger.h"
#import "GZIP.h"
#import "ASIHttpRequest/ASIDataCompressor.h"
#include <stdio.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    LogFatal(@"MSG_001", @"Fatal log!");
//    LogError(@"MSG_002", @"Error log!");
//    LogWarn(@"MSG_003", @"Warn log!");
//    LogInfo(@"MSG_004", @"Info log!");
//    LogDebug(@"MSG_005", @"Debug log!");
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapFatal:(id)sender {
    LogFatal(@"MSG_001", @"Fatal log! %@", @"Something fatal~");
}

- (IBAction)tapError:(id)sender {
    LogError(@"MSG_002", @"Error log! %@", @"Something error~");
}

- (IBAction)tapWarn:(id)sender {
    LogWarn(@"MSG_003", @"Warn log! %@", @"Something warn~");
}

- (IBAction)tapInfo:(id)sender {
    LogInfo(@"MSG_004", @"Info log! %@", @"Something info~");
}

- (IBAction)tapDebug:(id)sender {
    LogInfo(@"MSG_005", @"Debug log! %@", @"Something debug~");
}

- (IBAction)logAll:(id)sender {
    LogFatal(@"MSG_001", @"Fatal log! %@", @"Something fatal~");
    LogError(@"MSG_002", @"Error log! %@", @"Something error~");
    LogWarn(@"MSG_003", @"Warn log! %@", @"Something warn~");
    LogInfo(@"MSG_004", @"Info log! %@", @"Something info~");
    LogDebug(@"MSG_005", @"Debug log! %@", @"Something debug~");
}

- (IBAction)batchFatal:(id)sender {
    for (int i = 0; i < 100; ++i) {
        LogFatal(@"MSG_001", @"Fatal log! %@", @"Something fatal~");
    }
}

- (IBAction)batchError:(id)sender {
    for (int i = 0; i < 100; ++i) {
        LogError(@"MSG_002", @"Error log! %@", @"Something error~");
    }
}

- (IBAction)asyncError:(id)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        LogError(@"MSG_002", @"Error log! %@", @"Something error~");
    });
}

- (IBAction)encodeLogFile:(id)sender {
    LogFatal(@"log begin", @"xixixi");
    for (int i = 0; i < 1000; ++i) {
        LogError(@"haha", @"Something should happen again and again");
    }
    LogFatal(@"log end", @"hahaha");
}

- (IBAction)decodeLogFile:(id)sender {
    
    NSString *logFile = @"/Users/zky/temp/2016-07-27-11-10-05-1.log.archive";
    NSString *logFileDecoded = [logFile stringByAppendingString:@".temp"];
    
    LogFatal(@"decode begin", @"xixixi");
    
    [[NSFileManager defaultManager] createFileAtPath:logFileDecoded contents:[NSData data] attributes:nil];
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:logFileDecoded append:NO];
    [outputStream open];
    
    const char *charLogFile = [logFile UTF8String];
    
    FILE *file = fopen(charLogFile, "r");
    // check for NULL
    while(!feof(file)) {
        NSString *base64Line = readLineAsNSString(file);
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:base64Line options:0];
        NSString *decodedLine = [[[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding] stringByAppendingString:@"\r\n"];
        NSData *decodedData = [decodedLine dataUsingEncoding:NSUTF8StringEncoding];
        [outputStream write:[decodedData bytes] maxLength:[decodedData length]];
    }
    fclose(file);
    [outputStream close];
}

- (IBAction)testNilStr:(id)sender {
    NSString *nilStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"notReallyExists"];
    NSLog(@"hahaha %@ xixixi", nilStr);
    unsigned long len = [nilStr length];
    NSLog(@"length: %ld", len);
    
    NSNumber *num = nil;
    int x = [num intValue];
    NSLog(@"x: %ld", x);
}

- (IBAction)gzipFile:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = @"/Users/zky/temp/2016-07-27-11-10-05-1.log.archive.temp";
    NSString *gzipPath = [filePath stringByAppendingString:@".gz"];
    NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:filePath];
    NSData *outputData = [fileData gzippedData];
    [[NSFileManager defaultManager] createFileAtPath:gzipPath contents:outputData attributes:nil];
//    NSError *error = nil;
//    [ASIDataCompressor compressDataFromFile:filePath toFile:gzipPath error:&error];
//    if (error) {
//        NSLog(@"CompressError: %@", error.description);
//    }
}

- (IBAction)decodeFile:(id)sender {
    NSString *logFile = @"/Users/zky/temp/2016-07-27-02-30-09-1.log.archive";
    NSString *decodedFile = [logFile stringByAppendingString:@".temp"];
    
    [[NSFileManager defaultManager] createFileAtPath:decodedFile contents:[NSData data] attributes:nil];
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:decodedFile append:NO];
    [outputStream open];
    
    const char *charLogFile = [logFile UTF8String];
    
    FILE *file = fopen(charLogFile, "r");
    // check for NULL
    while(!feof(file)) {
        NSString *base64Line = readLineAsNSString(file);
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:base64Line options:0];
        NSString *decodedLine = [[[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding] stringByAppendingString:@"\n"];
        NSData *decodedData = [decodedLine dataUsingEncoding:NSUTF8StringEncoding];
        [outputStream write:[decodedData bytes] maxLength:[decodedData length]];
    }
    fclose(file);
    [outputStream close];
    
    logFile = @"/Users/zky/temp/2016-07-27-02-30-08-2.log.archive";
    decodedFile = [logFile stringByAppendingString:@".temp"];
    
    [[NSFileManager defaultManager] createFileAtPath:decodedFile contents:[NSData data] attributes:nil];
    outputStream = [NSOutputStream outputStreamToFileAtPath:decodedFile append:NO];
    [outputStream open];
    
    charLogFile = [logFile UTF8String];
    
    file = fopen(charLogFile, "r");
    // check for NULL
    while(!feof(file)) {
        NSString *base64Line = readLineAsNSString(file);
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:base64Line options:0];
        NSString *decodedLine = [[[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding] stringByAppendingString:@"\n"];
        NSData *decodedData = [decodedLine dataUsingEncoding:NSUTF8StringEncoding];
        [outputStream write:[decodedData bytes] maxLength:[decodedData length]];
    }
    fclose(file);
    [outputStream close];
}

#pragma mark Private method
NSString *readLineAsNSString(FILE *file)
{
    char buffer[4096];
    
    // tune this capacity to your liking -- larger buffer sizes will be faster, but
    // use more memory
    NSMutableString *result = [NSMutableString stringWithCapacity:1024];
    
    // Read up to 4095 non-newline characters, then read and discard the newline
    int charsRead;
    do
    {
        if(fscanf(file, "%4095[^\r\n]%n%*[\n\r]", buffer, &charsRead) == 1)
            [result appendFormat:@"%s", buffer];
        else
            break;
    } while(charsRead == 4095);
    
    return result;
}

@end
