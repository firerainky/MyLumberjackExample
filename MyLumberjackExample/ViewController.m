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
#import "ASIHttpRequest/ASIHTTPRequest.h"
#include <stdio.h>
#include "MyTest.h"

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
    ddLogLevel = DDLogLevelOff;
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
    
    MyTest *mt = [[MyTest alloc] init];
    [mt testLog];
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
    NSString *signKey = @"1000:314567058:FFEE7C6A-29CA-4177-880C-30D8D97F1443:signature=5453bbc9845ea4613d7cedc3ba639ee4e13159910cca04f5805048a44e395bbebe61c332bb1f9dc884c8aa15d8457a10c95b8458b79b53809d9c8cab7498c83d26bb02ef653004635b7d6b7d35e1e97e9b8e2a91a59b92c675af8746bc260a5077a24a34fd841d7be06d6b2b59fc9579edd2edc2f9f3b3e15c6c18c73a83309e";
    NSLog(@"%@", [[signKey dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0]);
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
    NSString *path = @"/Users/zky/temp";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileNames = [fileManager subpathsAtPath:path];
    for (NSString *fileName in fileNames) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        NSString *decodePath = [filePath stringByReplacingOccurrencesOfString:@".archive" withString:@".temp"];
        if ([filePath hasSuffix:@".log"]) {
            decodePath = [filePath stringByReplacingOccurrencesOfString:@".log" withString:@".temp"];
        }
        
//        NSString *decodePath = [filePath stringByReplacingOccurrencesOfString:@".log" withString:@".log.temp"];
        NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:decodePath append:NO];
        [outputStream open];
        
        const char *charLogFile = [filePath UTF8String];
        
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
    }
}

- (IBAction)httpsRequestTest:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://github.com"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestFinish:)];
    [request startAsynchronous];
}

- (IBAction)createCrash:(id)sender {
    // Create a crash
    NSArray *arr = @[];
    NSString *x = arr[0];
    NSLog(@"%@", x);
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

- (void)requestFailed:(ASIHTTPRequest *)theRequest {
    NSLog(@"response header: %@", [theRequest responseHeaders]);
    NSLog(@"response data  : %@", [theRequest responseData]);
    NSLog(@"response string: %@", [theRequest responseString]);
}

- (void)requestFinish:(ASIHTTPRequest *)theRequest {
    NSLog(@"response header: %@", [theRequest responseHeaders]);
    NSLog(@"response data  : %@", [theRequest responseData]);
    NSLog(@"response string: %@", [theRequest responseString]);
}

@end
