//
//  AlarmController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

protocol AlarmScheduler {
    func scheduleNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleNotification(alarm: Alarm) {
        
        
        let localNotification = UILocalNotification()
        localNotification.alertTitle = "Alarm"
        localNotification.alertBody = ""
        localNotification.category = "alarmCell"
    }
    func cancelLocalNotification(alarm: Alarm) {
        
    }
}

class AlarmController {
    static let sharedController = AlarmController()
//    var alarms = [Alarm]()
    var alarms: [Alarm]
    init() {
        self.alarms = []
        self.alarms = mockAlarms()
    }
    
    func mockAlarms() -> [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 30421, name: "Wake Up")
        let alarm2 = Alarm(fireTimeFromMidnight: 21683, name: "Keep Sleeping", enabled: false)
        let alarm3 = Alarm(fireTimeFromMidnight: 1800, name: "Go to bed")
        let alarm4 = Alarm(fireTimeFromMidnight: 68400, name: "Go to dinner")
        return [alarm1, alarm2, alarm3, alarm4]
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    }
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    func deleteAlarm(alarm: Alarm) {
        guard let indexOfAlarm = alarms.indexOf(alarm) else {
            return
        }
        alarms.removeAtIndex(indexOfAlarm)
    }
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
}