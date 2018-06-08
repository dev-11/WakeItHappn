//
//  Alarm.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/8/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation

class Alarm: NSObject {
    var arrivalTime = Date()
    var start = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)
    var end = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)
    var timeToGetReady = Date()
    
    init(arrivalTime: Date, start: Location, end: Location, timeToGetReady: Date) {
        self.arrivalTime = arrivalTime
        self.start = start
        self.end = end
        self.timeToGetReady = timeToGetReady
    }
}
