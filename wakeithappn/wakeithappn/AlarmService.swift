//
//  AlarmService.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/7/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation
import UserNotifications
import os.log

private let _alarmServiceSharedInstance = AlarmService()

class AlarmService {
    let center = UNUserNotificationCenter.current()
    
    class var sharedInstance : AlarmService {
        return _alarmServiceSharedInstance
    }
    
    init() {
        //request authorisation
        let options : UNAuthorizationOptions = [.alert, .sound];
        self.center.requestAuthorization(options: options){
            (granted, error) in
            if !granted {
                os_log("Notification permission not granted", type: .error)
            }
        }
    }
    
    ///Only ever allow a single alarm to be active
    func setAlarm(date: Date){
        self.center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
                os_log("Notification permission not granted", type: .error)
            } else {
                //Permisison granted, so let's set alarm
                
                // Swift
                let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                        title: "Snooze", options: [])
                let category = UNNotificationCategory(identifier: "UYLReminderCategory",
                                                      actions: [snoozeAction],
                                                      intentIdentifiers: [], options: [])
                
                //Set new time
                let content = UNMutableNotificationContent()
                content.title = "WAKE UP"
                content.body = "Based on your usual routine and today's travel conditions, it's time to get out of bed"
                content.sound = UNNotificationSound.default()
                
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                            repeats: false)
                let identifier = "com.wakeithappen.singlealarm" //Will replace any other notification with this identifier, ensuring we only have one alarm
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: content, trigger: trigger)
                // Swift
                self.center.setNotificationCategories([category])
                // Swift
                content.categoryIdentifier = "UYLReminderCategory"
                
                self.center.add(request, withCompletionHandler: { (error) in
                    if let error = error {
                        // Something went wrong
                        os_log("Failed to create notification", type: .error)
                    }
                })
                
            }
        }
    }
    
}

