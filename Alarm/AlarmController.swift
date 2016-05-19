//
//  AlarmController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

protocol AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm) {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: alarm.fireTimeFromMidnight)
        notification.alertTitle = "Alarm"
        notification.alertBody = ""
        notification.category = "alarmCell"
        notification.repeatInterval = NSCalendarUnit.Day
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        guard let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else {
            return
        }
        let alarmLocalNotifications = localNotifications.filter({$0.category == "alarmCell"})
        for notification in alarmLocalNotifications {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
}

class AlarmController: AlarmScheduler {
    private let keyAlarms = "keyAlarms"
    static let sharedController = AlarmController()
    var alarms = [Alarm]()

    init() {
        loadFromPersistentStorage()
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
        cancelLocalNotification(alarm)
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(alarms, toFile: filePath(keyAlarms))
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







