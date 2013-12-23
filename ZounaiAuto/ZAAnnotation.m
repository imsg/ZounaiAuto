//
//  ZAAnnotation.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-16.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import "ZAAnnotation.h"

@implementation ZAAnnotation

- (id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubitle
{
    self = [super init];
    if(self != nil)
    {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubitle;
        _pinColor = MKPinAnnotationColorGreen;
    }
    return self;
}

+ (NSString *)reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor{
    NSString *result = nil;
    switch (paramColor) {
        case MKPinAnnotationColorRed:{
            result = REUSABLE_PIN_RED;
            break;
        }
        case MKPinAnnotationColorGreen:{
            result = REUSABLE_PIN_GREEN;
            break;
        }
        case MKPinAnnotationColorPurple:{
            result = REUSABLE_PIN_PURPLE;
            break;
        }
    }
    return result;
}

@end
