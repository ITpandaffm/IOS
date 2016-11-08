//
//  ViewController.m
//  MapKitTest
//
//  Created by ffm on 16/9/24.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong)MKMapView *mapView;
@property (nonatomic, strong)CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%f, %f",self.mapView.userLocation.location.coordinate.longitude,self.mapView.userLocation.location.coordinate.latitude);
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == 0)
    {
        [self.manager requestAlwaysAuthorization];
    } else if (status == kCLAuthorizationStatusAuthorizedAlways)
    {
        self.mapView.userTrackingMode = 2;
        [self.manager startUpdatingLocation];
  //      self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"更新位置成功啦啦啦啦啦啦update location!");
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation *userCurrentLocation = userLocation.location;
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:userCurrentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *lastMark = [placemarks lastObject];
        NSDictionary *dict = lastMark.addressDictionary;
        
        //字典转为Json字符串
        NSData *jasonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:jasonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"定位成功啦，哟，%@", str);
    }];
    
    //定位成功之后可以停止继续更新定位了
    [self.manager stopUpdatingLocation];
}



- (IBAction)clickSearchBtn:(id)sender
{
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:self.myTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *mark in placemarks)
        {
            NSDictionary *dict = mark.addressDictionary;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
            NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//            NSLog(@"查找成功，地址是(FormattedAddressLines):%@",dict[@"FormattedAddressLines"]);
            NSLog(@"查找成功，地址是(Name):%@",dict[@"Name"]);
            NSLog(@"查找成功，地址是:%@",str);

//            self.mapView setRegion:<#(MKCoordinateRegion)#> animated:<#(BOOL)#>
            //设置地图中心点
            [self.mapView setCenterCoordinate:mark.location.coordinate animated:YES];
            //设置地图显示区域
            [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(mark.location.coordinate, 1000, 1000) animated:YES];
            
            //定义一个大头针
            MyAnnotation *annotation = [[MyAnnotation alloc] init];
            annotation.coordinate = mark.location.coordinate;
            annotation.title = dict[@"Name"];
            annotation.subtitle = @"子标题！😝";
            
            [self.mapView addAnnotation:annotation];
        }
        [self.myTextField resignFirstResponder];
        
    }];
}


//自定义大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MyAnnotationView *annotationView = [[MyAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    return annotationView;
}
#pragma mark - 懒加载
- (MKMapView *)mapView
{
    if (!_mapView)
    {
//        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        CGRect rect = self.view.bounds;
        rect.origin.y = 100;
        rect.size.height -= 100;
        _mapView = [[MKMapView alloc] initWithFrame:rect];
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

- (CLLocationManager *)manager
{
    if (!_manager)
    {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}
@end
