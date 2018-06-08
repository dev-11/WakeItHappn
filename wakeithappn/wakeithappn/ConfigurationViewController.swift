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
    @IBOutlet weak var getReadyTimeButton: UIButton!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var startLocationButton: UIButton!
    @IBOutlet weak var endLocationButton: UIButton!
    @IBOutlet weak var setAlarmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateTimePicker.isHidden = true
        dateTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        arrivalTimeButton.setTitle("09:00", for: .normal)
        
        if (self.startingLocation.name == "") {
            startLocationButton.setTitle("Select", for: .normal)
        } else {
            startLocationButton.setTitle(startingLocation.name, for: .normal)
        }
        
        getReadyTimeButton.setTitle("00:45", for: .normal)
        if (self.finishingLocation.name == "") {
            endLocationButton.setTitle("Select", for: .normal)
        } else {
            endLocationButton.setTitle(finishingLocation.name, for: .normal)
        }
        
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTap(gesture:)));
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func backgroundTap(gesture : UITapGestureRecognizer) {
        dateTimePicker.isHidden = true
        setAlarmButton.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var calendar: Calendar = Calendar.current
    
    // Alarm setup info
    var arrivalTime: Date = Date()
    var getReadyTime: Date = Date()
    var startingLocation: Location = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)
    var finishingLocation: Location = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dest = segue.destination as! SearchAddNewViewController
        if (segue.identifier == "selectStart") {
            dest.startLocation = true
        } else if (segue.identifier == "selectEnd") {
            dest.startLocation = false
        }
    }
    
    // Actions
    
    @IBAction func changeTime(_ sender: UIButton) {
        dateTimePicker.datePickerMode = UIDatePickerMode.time
        dateTimePicker.setDate(arrivalTime, animated: true)
        setAlarmButton.isHidden = true
        dateTimePicker.isHidden = false
    }
    
    @IBAction func changeGetReadyTime(_ sender: Any) {
        dateTimePicker.datePickerMode = UIDatePickerMode.countDownTimer
        dateTimePicker.setDate(getReadyTime, animated: true)
        setAlarmButton.isHidden = true
        dateTimePicker.isHidden = false
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        if (sender.datePickerMode == UIDatePickerMode.time) {
            arrivalTime = sender.date
            let hours = String(format: "%02d", calendar.component(.hour, from: sender.date))
            let minutes = String(format: "%02d", calendar.component(.minute, from: sender.date))
            let arrivalTimeToDisplay = "\(hours):\(minutes)"
            arrivalTimeButton.setTitle(arrivalTimeToDisplay, for: .normal)
        } else {
            getReadyTime = sender.date
            let hours = String(format: "%02d", calendar.component(.hour, from: sender.date))
            let minutes = String(format: "%02d", calendar.component(.minute, from: sender.date))
            let getReadyTimeToDisplay = "\(hours):\(minutes)"
            getReadyTimeButton.setTitle(getReadyTimeToDisplay, for: .normal)
        }
    }
    
    @IBAction func setAlarm(_ sender: Any) {
        WebService.sharedInstance.getAlarmTime()
        // AlarmService.sharedInstance.setAlarm(date: arrivalTime)
    }
    
}

