//
//  Utilities.m
//  WeatherOrNot
//
//  Created by Sasha on 06/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import "Utilities.h"
#import "Reachability.h"

@implementation Utilities

#pragma mark - Reachablity
+ (BOOL) isNetworkReachable
{
    Reachability *reachbility = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachbility currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return  NO;
    }
    
    return YES;
}

+ (NSNumber *)temperatureToCelcius:(double)fahrenheit
{
    double temperature = fahrenheit;
    double celcius = (temperature - 32) / 1.8;
    return [NSNumber numberWithDouble:celcius];
}

+ (NSNumber *)temperatureToFahrenheit:(double)celcius
{
    double temperature = celcius;
    double fahrenheit = (temperature * 1.8) + 32;
    return [NSNumber numberWithDouble:fahrenheit];
}

+(BOOL)isDateToday:(NSDate*)date
{
    if (date) {
        NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        
        if (([today day] == [otherDay day]) &&
            ([today month] == [otherDay month]) &&
            ([today year] == [otherDay year]) &&
            ([today era] == [otherDay era]))
        {
            return YES;
        }
    }
    
    return NO;
}

+ (NSDateFormatter *)defaultWeekDayDateFormater
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE HH:00"];
    });
    
    return dateFormatter;
}

+ (NSDateFormatter *)defaultHourDateFormater
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:00"];
    });
    
    return dateFormatter;
}

+ (NSString*)timeStampFromDate:(NSDate*)date
{
    if (date) {
        NSDateFormatter *formatter;
        NSString *dateString;
        if ([Utilities isDateToday:date])
        {
            formatter = [Utilities defaultHourDateFormater];
            dateString = [formatter stringFromDate:date];
            dateString = [NSString stringWithFormat:@"Today %@", dateString];
        }
        else
        {
            formatter = [Utilities defaultWeekDayDateFormater];
            dateString = [formatter stringFromDate:date];
        }
        return dateString;
    }
    return @"";
}

@end
