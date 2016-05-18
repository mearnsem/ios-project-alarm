//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    var alarm: Alarm?
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var alarmTitle: UITextField!
    @IBOutlet var enableAlarmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        setupView()
    }

    //MARK: - IBActions
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {
            return
        }
        AlarmController.sharedController.toggleEnabled(alarm)
        setupView()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = alarmTitle.text, let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        } else {
            AlarmController.sharedController.addAlarm(timeIntervalSinceMidnight, name: title)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        alarmTitle.text = alarm.name
        self.title = alarm.name
    }
    
    func setupView() {
        if alarm == nil {
            enableAlarmButton.hidden = true
        } else {
            enableAlarmButton.hidden = false
            if alarm?.enabled == true {
                enableAlarmButton.setTitle("Disable", forState: .Normal)
                enableAlarmButton.backgroundColor = UIColor.redColor()
                enableAlarmButton.setTitleColor(.whiteColor(), forState: .Normal)
            } else {
                enableAlarmButton.setTitle("Enable", forState: .Normal)
                enableAlarmButton.backgroundColor = UIColor.whiteColor()
                enableAlarmButton.setTitleColor(.blackColor(), forState: .Normal)
            }
        }
    }
}
