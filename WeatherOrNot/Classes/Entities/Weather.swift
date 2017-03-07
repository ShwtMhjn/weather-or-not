//
//  Weather.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//
//This class can be extended to show more properties at this level
import Foundation

@objc open class Weather : NSObject {
    var city : City?
    var forecast : [Forecast]?
    init(city: City?, forecast: [Forecast]?) {
        self.city = city
        self.forecast = forecast
    }
}
