//
//  Location.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/8/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation

class Location: NSObject {
    var name: String
    var formattedAddress: String
    var placeId: String
    var coordinates: (Double, Double)?
    
    init(placeId: String, name: String, formattedAddress: String, coordinates: (Double, Double)?) {
        self.name = name
        self.coordinates = coordinates
        self.formattedAddress = formattedAddress
        self.placeId = placeId
    }
}
