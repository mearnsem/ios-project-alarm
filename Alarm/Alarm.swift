//
//  Alarm.swift
//  Alarm
//
//  Created by Emily Mearns on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Alarm: Equatable {
    var fireTimeFromMidnight: NSTimeInterval
    var name: String
    var enabled: Bool
    var uuid: String
    
    init(fireTimeFromMidnight: NSTimeInterval, name: String, enabled: Bool, uuid: String) {
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = true
        self.uuid = NSUUID().UUIDString
    }
    
    var fireDate: NSDate? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return nil
        }
        let fireTimeFromThisMorning = NSDate(timeInterval: fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        return fireTimeFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        let minutesFromMidnight = fireTimeFromMidnight / 60
        let hoursFromMidnight = minutesFromMidnight / 60
        return ("\(hoursFromMidnight):\(minutesFromMidnight)")
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return (lhs.fireTimeFromMidnight == rhs.fireTimeFromMidnight && lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid)
}