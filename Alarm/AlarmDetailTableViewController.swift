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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        if let alarm = alarm {
            AlarmController.sharedController.toggleEnabled(alarm)
        }
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let timeInterval = DateHelper.thisMorningAtMidnight?.timeIntervalSinceDate(datePicker.date)
        if let alarm = alarm {
            guard let name = alarmNameLabel.text, timeInterval = timeInterval else { return }
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeInterval, name: name)
        } else {
            guard let name = alarmNameLabel.text, timeInterval = timeInterval else {return}
            AlarmController.sharedController.addAlarm(timeInterval, name: name)
        }
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func userTappedView(sender: AnyObject) {
        alarmNameLabel.resignFirstResponder()
    }


    // MARK: - Functions
    
    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: true)
        alarmNameLabel.text = alarm.name
    }
    
    func setupView() {
        if self.alarm == nil {
            enableButton.hidden = true
        } else {
            if self.alarm?.enabled == true {
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
