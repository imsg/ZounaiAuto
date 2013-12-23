//
//  main.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-11-26.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZAAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        int ret = 0;
        @try
        {
            ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([ZAAppDelegate class]));
        }
        @catch (NSException* e) { // to catch Objective-C exceptions
            NSLog(@"-- NSException caught -- ObjC exception name = '%@' reason = '%@'", [e name], [e reason]);
            // NSException contains stack-trace from the point where the exception was thrown
            NSLog(@"-- stack trace from NSException -- \n%@", [e callStackSymbols] );
            // Re-throw the exception to let the standard handler process it.
            @throw e;
        }
        return ret;
    }
}
