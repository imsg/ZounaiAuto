//
//  ZAHTTPManager.h
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-10.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZAHTTPManager : NSObject

+ (ZAHTTPManager *)sharedInstance;

- (void)getWeatherInfoWithCompletion:(void(^)(int code, NSDictionary *weatherInfo))completion;

@end
