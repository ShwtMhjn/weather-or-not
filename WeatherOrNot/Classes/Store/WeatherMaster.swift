//
//  WeatherMaster.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//
//Swift based store to fetch and hold weather

import Foundation
import CoreLocation

open class WeatherMaster : NSObject {
    
    //MARK: -- Fetch Weather Data --
    open func fetchWeatherDataForLocation (_ location : CLLocation, onSuccess: @escaping (_ weatherData : Weather ) -> (), onFailure: @escaping (_ error : Error) -> ()) {
        let weatherBusiness : WeatherBusiness = WeatherBusiness()
        weatherBusiness.callWeatherApi(for: location, onSuccess: { (weatherData) in
            let marshal : WeatherMarshal = WeatherMarshal.init(data: weatherData as! [String : AnyObject])
            let weatherObject = marshal.getWeatherObject()
            if let _weatherObject = weatherObject {
                onSuccess(_weatherObject);
            }
        }) { (error) in
            print(error as Any) //Handle error appropriately
        }
    }
}
