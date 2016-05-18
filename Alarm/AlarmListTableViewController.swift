//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Emily Mearns on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedController.alarms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell

        let alarm = AlarmController.sharedController.alarms[indexPath.row]
        cell?.updateWithAlarm(alarm)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let alarm = AlarmController.sharedController.alarms[indexPath.row]
        AlarmController.sharedController.deleteAlarm(alarm)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
//        var alarm = AlarmController.sharedController.alarms
//        AlarmController.sharedController.toggleEnabled(alarm)
        
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "alarmCell" {
            if let alarmDetailVC = segue.destinationViewController as? AlarmDetailTableViewController {
                if let alarmCell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(alarmCell) {
                        alarmDetailVC.alarm = AlarmController.sharedController.alarms[indexPath.row]
                    }
                }
            }
        }
    }


}
