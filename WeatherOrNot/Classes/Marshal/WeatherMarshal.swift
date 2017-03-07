//
//  WeatherMarshal.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

import Foundation

@objc open class WeatherMarshal : NSObject {
    var weatherObject : Weather?
    init(data : [String : AnyObject]) {
        super.init()
        let city : City? = getCity(cityData: data.dictionaryForKey(Constants.kCity))
        let forecastList : [Forecast]? = getForecastList(forecastData: data.arrayForKey(Constants.kList))
        
        weatherObject = Weather.init(city: city, forecast: forecastList!)
    }
    
    func getCity(cityData:[String : AnyObject]?) -> City? {
        let id = cityData?.integerForKey(Constants.kId)
        let name = cityData?.stringForKey(Constants.kName)
        let city : City = City.init(id: id, name: name)
        return city
    }
    
    func getForecastList(forecastData: [AnyObject]?) -> [Forecast]? {
        var forecastList : [Forecast]? = [Forecast]()
        var temp : NSNumber?
        var tempMin : NSNumber?
        var tempMax : NSNumber?
        var main : String?
        var weatherDescription : String?
        var date : Date?
        var icon : String?
        
        if let _forecastData = forecastData {
            for forecastDataItem in _forecastData {
                if let _forecastDataItem = forecastDataItem as? [String : AnyObject] {
                    let timeInterval = _forecastDataItem.doubleForKey(Constants.kDate)
                    let mainData = _forecastDataItem.dictionaryForKey(Constants.kMain)
                        if let _mainData = mainData as [String : AnyObject]? {
                            temp = NSNumber.init(value: (_mainData.doubleForKey(Constants.kTemp) - 273.15)) //Converted to Celcius
                            tempMin = NSNumber.init(value: (_mainData.doubleForKey(Constants.kTempMin) - 273.15)) //Converted to Celcius
                            tempMax = NSNumber.init(value: (_mainData.doubleForKey(Constants.kTempMax) - 273.15)) //Converted to Celcius
                    }
                
                    if let weatherData = _forecastDataItem.arrayForKey(Constants.kWeather)?.first as? [String : AnyObject] {
                        main = weatherData.stringForKey(Constants.kMain)
                        weatherDescription = weatherData.stringForKey(Constants.kDescription)
                        icon = weatherData.stringForKey(Constants.kIcon)
                        date = Date.init(timeIntervalSince1970: timeInterval)
                        let forecast = Forecast.init(date: date, temp: temp, temp_min: tempMin, temp_max: tempMax, main: main, weatherDescription:  weatherDescription, icon: icon)
                        forecastList?.append(forecast)
                    }
                }
            }
        }
        if let _forecastList = forecastList {
            return _forecastList
        }
        else {
            return forecastList
        }
        
    }
    
    open func getWeatherObject()->(Weather?){
        return weatherObject
    }
}
