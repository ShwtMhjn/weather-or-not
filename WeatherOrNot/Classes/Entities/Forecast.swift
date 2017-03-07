//
//  Forecast.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

import Foundation
@objc open class Forecast : NSObject {
    var date : Date?
    var temp : NSNumber?
    var temp_min : NSNumber?
    var temp_max : NSNumber?
    var main : String?
    var weatherDescription : String?
    var icon : String?
    
    init(date: Date?, temp: NSNumber?, temp_min: NSNumber?, temp_max: NSNumber?, main: String?, weatherDescription : String?, icon: String?) {
        self.date = date
        self.temp = temp
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
}
