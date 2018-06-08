//
//  WebService.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/8/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation
import Alamofire

private let _webServiceSharedInstance = WebService()

class WebService {
    
    let apiUrl = "http://localhost:5000/api/alarm"
    
    class var sharedInstance: WebService {
        return _webServiceSharedInstance
    }
    
    init() {
    }
    
    func getAlarmTime(arrivalTime: Date, from: (Double, Double), to: (Double, Double), getReadyTime: Date) -> Void {
        
        var params = ["alarmId": "702e5dd5-5395-484f-acb1-0b2436c8f8a4"]
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let arrivalString = formatter.string(from: arrivalTime)
        params["arrivalTime"] = arrivalString
        params["fromLat"] = String(from.0)
        params["fromLong"] = String(from.1)
        params["toLat"] = String(to.0)
        params["toLong"] = String(to.1)
        
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: getReadyTime)
        let minutes = calendar.component(.minute, from: getReadyTime)
        let minutesToGetReady = (hour * 60) + minutes
        params["minutesToGetReady"] = String(minutesToGetReady)
        
        Alamofire.request(apiUrl, parameters: params).responseJSON {
            response in
            print("response")
        }
    }
}
