//
//  AlarmController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    static let sharedController = AlarmController()
    var alarms = [Alarm]()
    
    init() {
        
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    }
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        deleteAlarm(alarm)
        addAlarm(fireTimeFromMidnight, name: name)
    }
    func deleteAlarm(alarm: Alarm) {
        guard let indexOfAlarm = alarms.indexOf(alarm) else {
            return
        }
        alarms.removeAtIndex(indexOfAlarm)
    }
    
}