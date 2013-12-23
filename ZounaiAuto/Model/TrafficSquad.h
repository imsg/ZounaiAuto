//
//  TrafficSquad.h
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-19.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TrafficSquad : NSManagedObject

@property (nonatomic, retain) NSString * squadId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phonenumber;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

@end
