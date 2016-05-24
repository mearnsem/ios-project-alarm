//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // MARK: - IBOutlets & Properties
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    var alarm: Alarm?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        setupView()
    }
    
    // MARK: - IBActions
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else { return }
        AlarmController.sharedController.toggleEnabled(alarm)
        setupView()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = alarmNameLabel.text, thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeInterval = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeInterval, name: title)
        } else {
            let alarm = AlarmController.sharedController.addAlarm(timeInterval, name: title)
            self.alarm = alarm
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    // MARK: - Functions
    
    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        alarmNameLabel.text = alarm.name
        self.title = alarm.name
    }
    
    func setupView() {
        if alarm == nil {
            enableButton.hidden = true
        } else {
            enableButton.hidden = false
            if alarm?.enabled == true {
                enableButton.setTitle("Disable", forState: .Normal)
                enableButton.backgroundColor = .redColor()
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
            } else {
                enableButton.setTitle("Enable", forState: .Normal)
                enableButton.backgroundColor = .whiteColor()
                enableButton.setTitleColor(.blackColor(), forState: .Normal)
            }
        }
    }

}
