//
//  WeatherCellData.h
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WeatherCellData : NSObject
{
}

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) UIImage *icon;

- (id)initWithForecast:(id)forecast;

@end
