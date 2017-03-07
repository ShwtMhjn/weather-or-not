//
//  WeatherCellData.m
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import "WeatherCellData.h"
#import "Utilities.h"
#import "WeatherOrNot-Swift.h"

@implementation WeatherCellData

- (id)initWithForecast:(id)forecast
{
    Forecast *forecastObject = (Forecast *)forecast;
    _date = [Utilities timeStampFromDate:forecastObject.date];
    _temperature = [NSString stringWithFormat:@"%.2f", [forecastObject.temp doubleValue]];
    _icon = [UIImage imageNamed:forecastObject.icon];
    return self;
}

@end

