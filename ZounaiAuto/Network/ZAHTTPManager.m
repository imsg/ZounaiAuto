//
//  ZAHTTPManager.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-10.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import "ZAHTTPManager.h"

#import "AFNetworking.h"

static NSString * const kUserAgentHeader = @"User-Agent";
static NSString * const kContentTypeHeader = @"Content-Type";
static NSString * const kUserAgentValue = @"ZounaiAuto";
static NSString * const kContentTypeValue = @"text/html; charset=utf-8";
static NSString * const kWeatherTianjinURL = @"http://m.weather.com.cn/data/101030100.html";

@interface ZAHTTPManager () {
    AFHTTPRequestOperationManager *_httpRequestMgr;
}

@end
@implementation ZAHTTPManager

+ (ZAHTTPManager *)sharedInstance {
    static dispatch_once_t predicate;
    static ZAHTTPManager *instance = nil;
    dispatch_once(&predicate, ^{
        instance = [[ZAHTTPManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
//        NSString *serverUrl = NSLocalizedStringFromTable(@"MG_SERVER_URL", SETTING_TABLE, @"MYGOOD_SERVER_URL");
        _httpRequestMgr = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        _httpRequestMgr.requestSerializer = [AFJSONRequestSerializer serializer];
        [_httpRequestMgr.requestSerializer setValue:kUserAgentValue forHTTPHeaderField:kUserAgentHeader];
//        [_httpRequestMgr.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    }
    return self;
}

- (void)getWeatherInfoWithCompletion:(void(^)(int code, NSDictionary *weatherInfo))completion
{
    _httpRequestMgr.responseSerializer = [AFJSONResponseSerializer serializer];
    _httpRequestMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [_httpRequestMgr GET:kWeatherTianjinURL
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                     NSHTTPURLResponse *response = operation.response;
                     NSLog(@"%@", responseObject);
                     NSDictionary *dict = [responseObject objectForKey:@"weatherinfo"];
                     
                     if (completion) {
                         completion(200, dict);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if (completion) {
                         completion(500, nil);
                     }
                 }];
}

@end
