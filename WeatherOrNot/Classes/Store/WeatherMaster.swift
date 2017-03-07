//
//  WeatherMaster.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

import Foundation
import CoreLocation

open class WeatherMaster : NSObject {

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
    //    self.accountBusiness.fetchGoalImages(goalImage, onSuccess: { (response) in
        print("Success")
    
//        onSuccess(response! as Data);
    
//    }) { (response, error) in
//        onFailure(error!);
//        print("Failure")
//    }
    }
}
