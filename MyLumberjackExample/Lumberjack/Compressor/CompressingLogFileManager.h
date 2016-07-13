#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"


@interface CompressingLogFileManager : DDLogFileManagerDefault
{
    BOOL upToDate;
    BOOL isCompressing;
}

@end
