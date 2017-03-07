//
//  Constants.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

import Foundation

struct Constants {
    
    //MARK: -- Parsing Keys
    //MARK: -- Parsing Keys -- COMMON --
    static let kEmptyString : String = ""
    static let kZeroInteger : Int   = 0
    static let kZeroDouble  : Double = 0
    static let kGenericDate : Date = Date.distantPast
    
    //MARK: -- Parsing Keys -- WEATHER --
    static let kList        : String = "list"
    static let kCity        : String = "city"
    
    //MARK: -- Parsing Keys -- CITY --
    static let kId          : String = "id"
    static let kName        : String = "name"

    //MARK: -- Parsing Keys -- FORECAST --
    static let kMain        : String = "main"
    static let kTemp        : String = "temp"
    static let kTempMin     : String = "temp_min"
    static let kTempMax     : String = "temp_max"
    static let kWeather     : String = "weather"
    static let kDescription : String = "description"
    static let kIcon        : String = "icon"
    static let kDate        : String = "dt"
    
    //MARK: -- Errors --
    static let kErrorDomainJSONSerializationFailure  : String = "JSONSerializationFailure"
    static let kErrorDescriptionJSONSerializationFailure : String = "Please use a valid file for JSON input"
}
