//
//  Utilities.h
//  WeatherOrNot
//
//  Created by Sasha on 06/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

//Reachability
+(BOOL) isNetworkReachable;

//Temperature
+ (NSNumber *)temperatureToCelcius:(double)fahrenheit;
+ (NSNumber *)temperatureToFahrenheit:(double)celcius;

//Date
+ (NSString*)timeStampFromDate:(NSDate*)date;

@end
