//
//  ViewController.m
//  CLLocationManagerTest
//
//  Created by ffm on 16/9/24.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *manager;
@property (nonatomic, strong)CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLAuthorizationStatus *status = [CLLocationManager authorizationStatus];
    if(status == kCLAuthorizationStatusNotDetermined)
    {
        [self.manager requestWhenInUseAuthorization];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        self.manager.delegate = self;
        [self.manager startUpdatingLocation];
    } else if (status == kCLAuthorizationStatusAuthorizedAlways)
    {
        [self.manager requestAlwaysAuthorization];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"经纬度是:%f,%f, 高度:%f, 楼层:%@, 水平:%f, 垂直:%f, 时间:%@ 速度:%f, 方向:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,currentLocation.altitude,currentLocation.floor,currentLocation.horizontalAccuracy,currentLocation.verticalAccuracy,currentLocation.timestamp, currentLocation.speed, currentLocation.course);
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            NSLog(@"%@",error);
            CLPlacemark *mark = [placemarks firstObject];
            NSLog(@"%@\n\n",mark.addressDictionary);
        NSLog(@"%@",mark.addressDictionary[@"name"]);
    }];
    [self.manager stopUpdatingLocation];

}

#pragma mark - 懒加载
- (CLLocationManager *)manager
{
    if (!_manager)
    {
        _manager = [[CLLocationManager alloc] init];
    }
    return _manager;
}
- (CLGeocoder *)geocoder
{
    if (!_geocoder)
    {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
@end
