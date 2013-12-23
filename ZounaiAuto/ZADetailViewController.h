//
//  ZADetailViewController.h
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-19.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestingStation;
@class TrafficSquad;
@interface ZADetailViewController : UITableViewController

@property (strong, nonatomic) TestingStation *testingStation;
@property (strong, nonatomic) TrafficSquad *trafficSquad;

@end
