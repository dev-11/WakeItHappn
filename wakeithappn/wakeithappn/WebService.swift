//
//  WebService.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/8/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation
//import Alamofire

private let _webServiceSharedInstance = WebService()

class WebService {
    
    let apiUrl = "http://localhost:5000/api"
    
    class var sharedInstance: WebService {
        return _webServiceSharedInstance
    }
    
    init() {
    }
    
    func getAlarmTime(alarm: Alarm) -> Void {
        
        // var params = ["alarmKey": "x"]
        
//        Alamofire.request(apiUrl).responseJSON {
//            response in
//            print("response")
//        }
    }
}
