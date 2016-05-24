//
//  AlarmController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmController {
    
    static let sharedController = AlarmController()
    var alarms = [Alarm]()
    private let kAlarms = "alarms"
    
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
        guard let indexOfAlarm = alarms.indexOf(alarm) else { return }
        alarms.removeAtIndex(indexOfAlarm)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(alarms, toFile: filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
        NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kAlarms))
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kAlarms)) as? [Alarm] else {return}
        self.alarms = alarms
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        return entriesPath
    }
}

protocol AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm) {
        
        let localNotification = UILocalNotification()
        localNotification.alertTitle = "Wake Up"
        localNotification.alertBody = "Quit sleepin, get to work!"
        localNotification.fireDate?.timeIntervalSinceDate(DateHelper.tomorrowMorningAtMidnight!)
        localNotification.category = "localNotificationTag"
        localNotification.repeatInterval = NSCalendarUnit.Day
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    func cancelLocalNotification(alarm: Alarm) {
        guard let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else {return}
        let alarmLocalNotifications = localNotifications.filter({$0.category == "localNotificationTag"})
        UIApplication.sharedApplication().cancelLocalNotification(alarmLocalNotifications)
    }
}







