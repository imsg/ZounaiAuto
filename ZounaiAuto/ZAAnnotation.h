//
//  ZAAnnotation.h
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-16.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define REUSABLE_PIN_RED @"Red"
#define REUSABLE_PIN_GREEN @"Green"
#define REUSABLE_PIN_PURPLE @"Purple"

@interface ZAAnnotation : NSObject <MKAnnotation>

//显示标注的经纬度
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

//标注的标题
@property (nonatomic,copy,readonly) NSString *title;

//标注的子标题
@property (nonatomic,copy,readonly) NSString *subtitle;

@property (nonatomic, readonly) MKPinAnnotationColor pinColor;

- (id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramTitle;
+ (NSString *)reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor;

@end
