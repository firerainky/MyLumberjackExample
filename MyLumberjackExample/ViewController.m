//
//  ViewController.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/5.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "ViewController.h"
#import "Logger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LogFatal(@"MSG_001", @"Fatal log!");
    LogError(@"MSG_002", @"Error log!");
    LogWarn(@"MSG_003", @"Warn log!");
    LogInfo(@"MSG_004", @"Info log!");
    LogDebug(@"MSG_005", @"Debug log!");
    
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
@end
