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
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
    }
    
    func updateWithAlarm(alarm: Alarm) {
        datePicker.date = alarm.fireDate!
        alarmTitle.text = alarm.name
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
