//
//  AlarmController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    static let sharedController = AlarmController()
    
    var alarms = [Alarm]()
    
    init() {
        self.alarms = mockAlarms()
    }
    
    func mockAlarms() -> [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 28800, name: "Wake Up")
        let alarm2 = Alarm(fireTimeFromMidnight: 45000, name: "Lunch Time", enabled: false)
        return [alarm1, alarm2]
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        deleteAlarm(alarm)
        addAlarm(fireTimeFromMidnight, name: name)
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let indexOfAlarm = alarms.indexOf(alarm) else { return }
        alarms.removeAtIndex(indexOfAlarm)
    }
}