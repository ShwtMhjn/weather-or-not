//
//  WeatherStore.h
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//
//Objective C based store to fetch and hold weather 
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherBusiness.h"

//Sucess block for service call
typedef void (^WeatherObjectFetchSuccess) (id weatherData);

//Failure block for service call
typedef void (^WeatherObjectFetchFailure) (NSError *error);

@interface WeatherStore : NSObject

- (instancetype) init __attribute__((unavailable("Use +[FILAccountStore sharedInstance] instead")));
+ (instancetype) new __attribute__ ((unavailable("Use +[FILAccountStore sharedInstance] instead")));

+ (instancetype)sharedInstance;

- (void) fetchWeatherDataForLocation:(CLLocation *)location onSuccess:(WeatherObjectFetchSuccess)onSuccessBlock onFailure:(WeatherObjectFetchFailure)onFailureBlock;

@end
