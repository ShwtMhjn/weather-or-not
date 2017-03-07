//
//  WeatherBusiness.h
//  WeatherOrNot
//
//  Created by Sasha on 06/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//Success block for service call
typedef void (^WeatherFetchSuccess) (NSDictionary *weatherData);

//Failure block for service call
typedef void (^WeatherFetchFailure) (NSError *error);

@interface WeatherBusiness : NSObject

- (void) callWeatherApiForLocation:(CLLocation *)location onSuccess:(WeatherFetchSuccess)onSuccessBlock onFailure:(WeatherFetchFailure)onFailureBlock;

@end
