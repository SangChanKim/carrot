//
//  SetupViewController.swift
//  Carrot
//
//  Created by Kevin Kim on 1/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import Parse

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hard coded account and customer id
        let accountId = "56241a14de4bf40b17112f02"
        let customerId = "56241a13de4bf40b1711224d"
        PFUser.currentUser()?.setObject(accountId, forKey: "account_id")
        PFUser.currentUser()?.setObject(customerId, forKey: "customer_id")
        PFUser.currentUser()!.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("success posting account and customer id")
                
                
                let currentUserID = PFUser.currentUser()?.objectId!
                print("Objectid: \(currentUserID)")
                
                
                PFCloud.callFunctionInBackground("processPurchases", withParameters: ["object_id" : currentUserID!]) { (returnData: AnyObject?, error: NSError?) -> Void in
                    if (error == nil) {
                        if let data = returnData {
                            print("data = \(data)")
                            
                            let results = self.convertStringToDictionary(data as! String)
                            
                            
                            var items : [Item] = []
                            
                            for (key,value) in results! {
                                var newItem = Item()
                                newItem.itemName = key
                                newItem.price = value as! Double
                                items.append(newItem)
                            }
                            
                        }
                    } else {
                        print("Totals Error = \(error)")
                    }
                }
                
                
                
                
                
            } else {
                print("failed posting account and customer id")
            }
        }

        

        // Do any additional setup after loading the view.
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String:AnyObject]
            return json!
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

struct Item {
    var itemName = ""
    var price: Double = 0.0
}
