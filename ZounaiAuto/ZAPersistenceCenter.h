//
//  ZAPersistenceCenter.h
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-19.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZAPersistenceCenter : NSObject

+ (ZAPersistenceCenter *)sharedInstance;

- (void)saveStation;
- (void)saveSquad;
@end
