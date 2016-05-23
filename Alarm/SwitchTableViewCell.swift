//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Emily Mearns on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // MARK: - IBOutlets & Properties
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    var alarm: Alarm?
    
    
    // MARK: - IBActions
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate?.switchCellSwitchValueChanged(self)
    }

    func updateWithAlarm(alarm: Alarm) {
        self.alarm = alarm
        self.timeLabel.text = alarm.fireTimeAsString
        self.nameLabel.text = alarm.name
        self.alarmSwitch.on = alarm.enabled
    }
}

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}