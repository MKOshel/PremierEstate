//
//  MapSearchVC.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "MapSearchVC.h"
#import "PortfolioVC.h"
#import "RequestManager.h"
#import "ListingsVC.h"
#import "Defines.h"
#import "AppDelegate.h"

@interface MapSearchVC ()
{
    MKPointAnnotation *annotation;
    NSString* radius;
}
@end

@implementation MapSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
    [self initLocationManager];

    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

-(void)customizeView
{
    _btnSearch.layer.cornerRadius = 5;
    _btnSearch.layer.masksToBounds = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
}


-(void)endEditing:(UITapGestureRecognizer*)sender
{
    [self.view endEditing:YES];
}


#pragma mark Location
-(void)initLocationManager
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    annotation = [[MKPointAnnotation alloc]init];
}



-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // zoom to region containing the user location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [_viewMap setRegion:[_viewMap regionThatFits:region] animated:YES];
    
    if (annotation == nil) {
        annotation = [[MKPointAnnotation alloc] init];
    }
    annotation.coordinate = userLocation.coordinate;
//    point.title = @"";
//    point.subtitle = @"";
    
    [_viewMap addAnnotation:annotation];
}


#pragma mark === TextField delegate


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    radius = textField.text;
    
}


#pragma mark === Search Action
- (IBAction)onSearchProperty:(UIButton *)sender
{
    NSString* lat = [NSString stringWithFormat:@"%f",annotation.coordinate.latitude];
    NSString* lng = [NSString stringWithFormat:@"%f",annotation.coordinate.longitude];
    
    ListingsVC* listingsVC = [[ListingsVC alloc]initWithNibName:@"ListingsVC" bundle:nil];
    
    [listingsVC setIsMapSearch:YES];
    [listingsVC setRadius:_textFieldRadius.text];
    [listingsVC setLatitude:lat];
    [listingsVC setLongitude:lng];
    
    
    [appDelegate.navController pushViewController:listingsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
