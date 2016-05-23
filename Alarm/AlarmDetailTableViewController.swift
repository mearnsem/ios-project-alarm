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
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
    }

    // MARK: - Functions
    
    func updateWithAlarm(alarm: Alarm) {
        self.datePicker.date = alarm.fireDate!
        self.alarmNameLabel.text = alarm.name
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
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
