//
//  WeatherBusinessTests.m
//  WeatherOrNot
//
//  Created by Sasha on 06/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebConnectionHandler.h"
#import "WeatherBusiness.h"
#import <CoreLocation/CoreLocation.h>

@interface WeatherBusinessTests : XCTestCase <CLLocationManagerDelegate>
{
    WebConnectionHandler *webConnectionHandler;
    WeatherBusiness *weatherBusiness;
    CLLocationManager *locationManager;
}

@end

@implementation WeatherBusinessTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    webConnectionHandler = [[WebConnectionHandler alloc] init];
    weatherBusiness = [[WeatherBusiness alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    webConnectionHandler = nil;
    weatherBusiness = nil;
    [super tearDown];
}

- (void)testConnection {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]];
    [webConnectionHandler executeRequest:request onSuccess:^(NSURLResponse *response, NSData *data) {
        XCTAssertNotNil(response, "Response is nil");
    } failure:^(NSURLResponse *response, NSData *data, NSError *error) {
        XCTAssert("Connection failed");
    }];
}

- (void)testWeatherAPICall {
    CLLocation *location = [locationManager location];
    [weatherBusiness callWeatherApiForLocation:location onSuccess:^(NSDictionary *weatherData) {
        XCTAssertNotNil(weatherData, "Response is nil");
    } onFailure:^(NSError *error) {
        XCTAssert("Connection failed");
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
