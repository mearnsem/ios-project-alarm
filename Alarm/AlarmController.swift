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
    private let keyAlarms = "keyAlarms"
    static let sharedController = AlarmController()
    var alarms = [Alarm]()

    init() {
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
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
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(keyAlarms))
    }
    
    func loadFromPersistentStorage() {
        NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(keyAlarms))
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(keyAlarms)) as? [Alarm] else {
            return
        }
        self.alarms = alarms
    }
    
    func filePath(key: String) -> String {
        let directorySearchReults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath = directorySearchReults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        return entriesPath
    }
    
}







