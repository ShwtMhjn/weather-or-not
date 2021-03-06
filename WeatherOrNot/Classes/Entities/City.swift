//
//  City.swift
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//
//This class can be extended to show more properties at this level

import Foundation

@objc open class City : NSObject {
    var id : Int?
    var name : String?
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
