//
//  GoalViewController.swift
//  Carrot
//
//  Created by Kevin Kim on 1/8/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import Parse

class GoalViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var carrotName: String = ""
    var carrotPrice: Double = 1.0
    var user_name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.adjustsFontSizeToFitWidth = true
        priceTextField.adjustsFontSizeToFitWidth = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEditingChanged(sender: UITextField) {
        let price = (priceTextField.text! as NSString).doubleValue
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        priceTextField.text = formatter.stringFromNumber(price)
    }
    
    @IBAction func seeProfilePushed(sender: UIButton) {
        if (nameTextField.text != "" && priceTextField.text != "0") {
            let goalName = nameTextField.text
            let goalPrice = (priceTextField.text! as NSString).doubleValue
            
            PFUser.currentUser()?.setObject(goalName!, forKey: "goal_item")
            PFUser.currentUser()?.setObject(goalPrice, forKey: "goal_price")
            PFUser.currentUser()?.setObject(carrotName, forKey: "carrot_item")
            PFUser.currentUser()?.setObject(carrotPrice, forKey: "carrot_price")
            
            getCustomerInfo()
        }
    }
    
    func getCustomerInfo() {
        PFCloud.callFunctionInBackground("getCustomerFromObjectId", withParameters: ["object_id" : PFUser.currentUser()!.objectId!]) { (returnData: AnyObject?, error: NSError?) -> Void in
            if (error == nil) {
                if let data = returnData {
                    let results = Utilities.convertStringToDictionary(data as! String)
                    let first_name = results!["first_name"] as! String
                    let last_name = results!["last_name"] as! String
                    
                    self.user_name = first_name + " " + last_name
                    self.performSegueWithIdentifier("seeProfile", sender: self)
                }
            } else {
                print("Customer Error = \(error)")
            }
        }
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "seeProfile") {
            let destVC = segue.destinationViewController as! MainViewController
            destVC.goalName = PFUser.currentUser()!.objectForKey("goal_item") as! String
            destVC.goalPrice = PFUser.currentUser()!.objectForKey("goal_price") as! Double
            destVC.carrotName = PFUser.currentUser()!.objectForKey("carrot_item") as! String
            destVC.carrotPrice = PFUser.currentUser()!.objectForKey("carrot_price") as! Double
            destVC.username = user_name
        }
    }
    
}
