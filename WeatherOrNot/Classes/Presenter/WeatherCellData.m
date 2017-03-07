//
//  WeatherCellData.m
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

//As the name suggests, this class holds the data that is required to populate the tableView cell. For a bigger implementation, this class can be extended to show more kinds of values

#import "WeatherCellData.h"
#import "Utilities.h"
#import "WeatherOrNot-Swift.h"

@implementation WeatherCellData

- (id)initWithForecast:(id)forecast
{
    Forecast *forecastObject = (Forecast *)forecast;
    _date = [Utilities timeStampFromDate:forecastObject.date]; //The timestamp should be according to the date
    _temperature = [NSString stringWithFormat:@"%.2f", [forecastObject.temp doubleValue]]; //temperature upto 2 decimal places
    _icon = [UIImage imageNamed:forecastObject.icon]; //icon corresponding to the weather conditions
    return self;
}

@end

