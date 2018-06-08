//
//  ShowAlarmViewController.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/8/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation

import UIKit

class ShowAlarmViewController: UIViewController {

    var alarmDate = Date()
    
    @IBOutlet weak var showAlarmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var calendar: Calendar = Calendar.current
        let hours = String(format: "%02d", calendar.component(.hour, from: self.alarmDate))
        let minutes = String(format: "%02d", calendar.component(.minute, from: self.alarmDate))
        let arrivalTimeToDisplay = "\(hours):\(minutes)"
        showAlarmLabel.text = arrivalTimeToDisplay
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
