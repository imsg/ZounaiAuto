//
//  ZAViewController.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-11-26.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import "ZAViewController.h"
#import "ZADetailViewController.h"
#import "ZAAnnotation.h"
#import "UIViewController+MMDrawerController.h"
#import "CoreData+MagicalRecord.h"
#import "TestingStation.h"
#import "TrafficSquad.h"

@interface ZAViewController () {
    MKMapView *_mkMapView;
    NSMutableArray *_testingStationArray;
    NSMutableArray *_trafficSquadArray;
    UISegmentedControl *_segmentedControl;
    BOOL regionSetDone;
//    MKUserLocation *_mkUserLocation;
}

@end

@implementation ZAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _mkMapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
    _mkMapView.delegate = self;
    _mkMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mkMapView];
    _mkMapView.showsUserLocation = YES;
//    self.navigationItem.title = @"奏耐汽车";
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"去验车", @"交罚款"]];
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self
                         action:@selector(segmentedControlValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(drawerButtonPressed:)];
    
    _testingStationArray = [NSMutableArray array];
    _trafficSquadArray = [NSMutableArray array];
    [self loadTestingStations];
//    CLLocationCoordinate2D locationHX = CLLocationCoordinate2DMake(39.060793, 117.235979);//(39.067132, 117.242364);
//    ZAAnnotation *annotationHX = [[ZAAnnotation alloc]initWithCoordinates:locationHX title:@"河西检测站" subTitle:@"河西区解放南路珠江道75号"];
//    [_mkMapView addAnnotation:annotationHX];
//    
//    CLLocationCoordinate2D locationHQ = CLLocationCoordinate2DMake(39.174755, 117.140678);
//    ZAAnnotation *annotationHQ = [[ZAAnnotation alloc] initWithCoordinates:locationHQ title:@"红桥监测站" subTitle:@"红桥区咸阳北路"];
//    [_mkMapView addAnnotation:annotationHQ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        ((ZADetailViewController *)segue.destinationViewController).testingStation = sender;
    }
    else if (_segmentedControl.selectedSegmentIndex == 1) {
        ((ZADetailViewController *)segue.destinationViewController).trafficSquad = sender;
    }
}

#pragma mark - MKMapViewDelegation

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (userLocation && !regionSetDone) {
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.2;
        span.longitudeDelta = 0.2;
        CLLocationCoordinate2D location;
        location.latitude = userLocation.coordinate.latitude;
        location.longitude = userLocation.coordinate.longitude;
        region.span = span;
        region.center = location;
        [mapView setRegion:region animated:YES];
        regionSetDone = YES;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView * result = nil;
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKUserLocation *userLocation = (MKUserLocation *)annotation;
        if (userLocation) {
//            [mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.2, 0.2)) animated:YES];
//            result = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyCell"];
//            [result setCanShowCallout:YES];
        }
    }
    else if ([annotation isKindOfClass:[ZAAnnotation class]]) {
        ZAAnnotation *senderAnnotation = (ZAAnnotation *)annotation;
        NSString * pinReusableIdentifier = [ZAAnnotation reusableIdentifierforPinColor:senderAnnotation.pinColor];
        //    static NSString *pinReusableIdentifier = @"pinIdentifier";
        MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinReusableIdentifier];
            [annotationView setCanShowCallout:YES];
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [button addTarget:self action:@selector(annotationViewPressed:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = button;
        
        annotationView.opaque = NO;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        annotationView.selected = YES;
        annotationView.calloutOffset = CGPointMake(15, 15);
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFIcon.png"]];
        annotationView.leftCalloutAccessoryView = imageView;
        
        result = annotationView;
    }
    return result;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    ZAAnnotation *annotation = view.annotation;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ZADetailViewController *detailView = [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    if (_segmentedControl.selectedSegmentIndex == 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", annotation.title];
        TestingStation *station = [TestingStation MR_findFirstWithPredicate:predicate];
        if (station && detailView) {
//            [self performSegueWithIdentifier:@"DetailView" sender:station];
            detailView.testingStation = station;
            detailView.trafficSquad = nil;
            [self.navigationController pushViewController:detailView animated:YES];
        }
    }
    else if (_segmentedControl.selectedSegmentIndex == 1) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", annotation.title];
        TrafficSquad *squad = [TrafficSquad MR_findFirstWithPredicate:predicate];
        if (squad && detailView) {
//            [self performSegueWithIdentifier:@"DetailView" sender:squad];
            detailView.testingStation = nil;
            detailView.trafficSquad = squad;
            [self.navigationController pushViewController:detailView animated:YES];
        }
    }
}

#pragma mark - Action
- (void)segmentedControlValueChanged:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if (segment) {
        if (segment.selectedSegmentIndex == 0) {
            [_mkMapView removeAnnotations:_trafficSquadArray];
            [self loadTestingStations];
        }
        else if (segment.selectedSegmentIndex == 1) {
            [_mkMapView removeAnnotations:_testingStationArray];
            [self loadTrafficSquad];
        }
    }
}

- (void)drawerButtonPressed:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Private

- (void)loadTestingStations
{
    NSArray *stations = [TestingStation MR_findAll];
    for (TestingStation *station in stations) {
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([station.latitude floatValue], [station.longitude floatValue]);
        ZAAnnotation *annotation = [[ZAAnnotation alloc] initWithCoordinates:location title:station.name subTitle:station.address];
        [_testingStationArray addObject:annotation];
    }
    if (_testingStationArray && _testingStationArray.count > 0) {
        [_mkMapView addAnnotations:_testingStationArray];
//        [_mkMapView showAnnotations:_testingStationArray animated:YES];
    }
}

- (void)loadTrafficSquad
{
    NSArray *squads = [TrafficSquad MR_findAll];
    for (TrafficSquad *squad in squads) {
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([squad.latitude floatValue], [squad.longitude floatValue]);
        ZAAnnotation *annotation = [[ZAAnnotation alloc] initWithCoordinates:location title:squad.name subTitle:squad.address];
        [_trafficSquadArray addObject:annotation];
    }
    if (_trafficSquadArray && _trafficSquadArray.count > 0) {
        [_mkMapView addAnnotations:_trafficSquadArray];
//        [_mkMapView showAnnotations:_trafficSquadArray animated:YES];
    }
}

@end
