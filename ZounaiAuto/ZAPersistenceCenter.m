//
//  ZAPersistenceCenter.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-19.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import "ZAPersistenceCenter.h"
#import "TestingStation.h"
#import "TrafficSquad.h"
#import "CoreData+MagicalRecord.h"

@implementation ZAPersistenceCenter

+ (ZAPersistenceCenter *)sharedInstance
{
    static dispatch_once_t predicate;
    static ZAPersistenceCenter *instance = nil;
    dispatch_once(&predicate, ^{
        instance = [[ZAPersistenceCenter alloc] init];
    });
    return instance;
}

- (void)saveStation
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"stationId == %@", @"1000"];
        TestingStation *station = [TestingStation MR_findFirstWithPredicate:predicate inContext:localContext];
        if (!station) {
            station = [TestingStation MR_createInContext:localContext];
            station.stationId = @"1000";
            station.name = @"河西检测站";
            station.address = @"河西区解放南路珠江道75号";
            station.latitude = @(39.060793);
            station.longitude = @(117.235979);
            station.phonenumber = @"88242624";
        }
        predicate = [NSPredicate predicateWithFormat:@"stationId == %@", @"1001"];
        TestingStation *station1 = [TestingStation MR_findFirstWithPredicate:predicate inContext:localContext];
        if (!station1) {
            station1 = [TestingStation MR_createInContext:localContext];
            station1.stationId = @"1001";
            station1.name = @"红桥检测站";
            station1.address = @"红桥区光荣道保康路13号";
            station1.latitude = @(39.174755);
            station1.longitude = @(117.140678);
            station1.phonenumber = @"26570039";
        }
    } completion:^(BOOL success, NSError *error) {
        if (error) {
            NSLog(@"Saved data successfully");
        } else {
            NSLog(@"saved data failure");
        }
    }];
}

- (void)saveSquad
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"squadId == %@", @"2000"];
        TrafficSquad *station = [TrafficSquad MR_findFirstWithPredicate:predicate inContext:localContext];
        if (!station) {
            station = [TrafficSquad MR_createInContext:localContext];
            station.squadId = @"2000";
            station.name = @"和平支队";
            station.address = @"和平区山西路崇仁里12号";
            station.latitude = @(39.118121);
            station.longitude = @(117.208733);
            station.phonenumber = @"23398244";
        }
        predicate = [NSPredicate predicateWithFormat:@"squadId == %@", @"2001"];
        TrafficSquad *station1 = [TrafficSquad MR_findFirstWithPredicate:predicate inContext:localContext];
        if (!station1) {
            station1 = [TrafficSquad MR_createInContext:localContext];
            station1.squadId = @"2001";
            station1.name = @"河西支队";
            station1.address = @"河西区洞庭路复印纸厂对面	";
            station1.latitude = @(39.069021);
            station1.longitude = @(117.250469);
            station1.phonenumber = @"28115853";
        }
    } completion:^(BOOL success, NSError *error) {
        if (error) {
            NSLog(@"Saved data successfully");
        } else {
            NSLog(@"saved data failure");
        }
    }];
}

@end
