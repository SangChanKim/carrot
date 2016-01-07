//
//  MainViewController.swift
//  Carrot
//
//  Created by Kevin Kim on 1/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import Foundation
import Parse
import CircleProgressView

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalSavedLabel: UILabel!
    @IBOutlet weak var totalSpentLabel: UILabel!
    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var carrotProgressView: CircleProgressView!
    @IBOutlet weak var megaProgressView: CircleProgressView!
    
    //let user: PFUser = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "didRefresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidLayoutSubviews() {
        setUpSegmentedControl()
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("transactionCell", forIndexPath: indexPath) as! TransactionTableViewCell
        
        return cell
    }
    
    func didRefresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    // MARK: - Segmented Control
    
    private func setUpSegmentedControl() {
        dateSegment.tintColor = UIColor.orangeColor()
        
        let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Light", size: 10.0)!, forKey: NSFontAttributeName)
        dateSegment.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    }
    
    // MARK: - Network
    
    func getData() {
        //let query = PFUser.query()
        PFCloud.callFunctionInBackground("getPurchasesForAccount", withParameters: ["account_id" : PFUser.currentUser()!["account_id"]]) { (result: AnyObject?, error: NSError?) -> Void in
            if (error == nil) {
                print("RESULTS = \(result)")
            } else {
                print("error = \(error)")
            }
        }
        
//        PFCloud.callFunctionInBackground("getPurchasesForAccount", withParameters: ["account_id":PFUser.currentUser()!["account_id"]]) { (result: AnyObject, error: NSError) -> Void in
//            if (error == nil) {
//                
//            } else {
//                print("purchase network error = \(error)")
//            }
//        }
    }
    
    
    
    
    
    
    
    
    
    
}