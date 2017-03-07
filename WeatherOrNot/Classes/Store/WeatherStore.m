//
//  WeatherStore.m
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import "WeatherStore.h"
#import "WeatherBusiness.h"
#import "WeatherOrNot-Swift.h"

@implementation WeatherStore

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void) fetchWeatherDataForLocation:(CLLocation *)location onSuccess:(WeatherObjectFetchSuccess)onSuccessBlock onFailure:(WeatherObjectFetchFailure)onFailureBlock

{
    WeatherBusiness *weatherBusiness = [[WeatherBusiness alloc] init];
    [weatherBusiness callWeatherApiForLocation:location onSuccess:^(NSDictionary *weatherData) {
        
        WeatherMarshal *marshal = [[WeatherMarshal alloc] initWithData:weatherData];
        onSuccessBlock([marshal getWeatherObject]);
    } onFailure:^(NSError *error) {
        //Throw proper error on UI
        NSError *fetchError = error;
        onFailureBlock(fetchError);
    }];
}
@end
