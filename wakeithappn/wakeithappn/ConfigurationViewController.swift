//
//  ViewController.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/7/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    // Outlets
    @IBOutlet weak var arrivalTimeButton: UIButton!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var startLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateTimePicker.isHidden = true
        
        arrivalTimeButton.setTitle("09:00", for: .normal)
        if (self.startingLocation.name == "") {
            startLocationButton.setTitle("Select", for: .normal)
        } else {
            startLocationButton.setTitle(startingLocation.name, for: .normal)
        }
        
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTap(gesture:)));
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func backgroundTap(gesture : UITapGestureRecognizer) {
        dateTimePicker.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var calendar: Calendar = Calendar.current
    
    // Alarm setup info
    var arrivalTime: Date = Date()
    var startingLocation: Location = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)
    var finishingLocation: Location = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)

    
    
    // Actions
    
    @IBAction func changeTime(_ sender: UIButton) {
        dateTimePicker.datePickerMode = UIDatePickerMode.time
        dateTimePicker.setDate(arrivalTime, animated: true)
        dateTimePicker.isHidden = false
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        arrivalTime = sender.date
        let hours = String(format: "%02d", calendar.component(.hour, from: sender.date))
        let minutes = String(format: "%02d", calendar.component(.minute, from: sender.date))
        let arrivalTimeToDisplay = "\(hours):\(minutes)"
        arrivalTimeButton.setTitle(arrivalTimeToDisplay, for: .normal)
    }
    
    @IBAction func setAlarm(_ sender: Any) {
        AlarmService.sharedInstance.setAlarm(date: arrivalTime)
    }
    
}

