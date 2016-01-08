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
    
    var transcationData: Data = Data()
    var username: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "didRefresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        tableView.allowsSelection = false
        
        totalSpentLabel.adjustsFontSizeToFitWidth = true
        totalSavedLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.adjustsFontSizeToFitWidth = true
        
        usernameLabel.text = username
        
        refreshData()
    }
    
    override func viewDidLayoutSubviews() {
        setUpSegmentedControl()
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transcationData.descriptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("transactionCell", forIndexPath: indexPath) as! TransactionTableViewCell
        
        let index = indexPath.row
        
        cell.descripLabel.text = self.transcationData.descriptions[index]
        cell.priceLabel.text = "$\(Utilities.getCurrencyValue(self.transcationData.amounts[index]))"
        cell.savedLabel.text = "+$\(Utilities.getCurrencyValue(self.transcationData.change[index]))"
        cell.dayLabel.text = transcationData.days[index]
        cell.monthLabel.text = transcationData.months[index]
        
        return cell
    }
    
    
    
    func didRefresh(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Segmented Control
    
    private func setUpSegmentedControl() {
        dateSegment.tintColor = UIColor.orangeColor()
        
        let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Light", size: 10.0)!, forKey: NSFontAttributeName)
        dateSegment.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    }
    
    // MARK: - Progress View
    
    private func getPercentage(amount: Double, total: Double) {
        
    }
    
    // MARK: - Network
    
    private func refreshData() {
        getTransactionData()
        getTotalsData()
    }
    
    func getTransactionData() {
        PFCloud.callFunctionInBackground("getPurchasesForUser", withParameters: ["object_id" : PFUser.currentUser()!.objectId!]) { (returnData: AnyObject?, error: NSError?) -> Void in
            if (error == nil) {
                if let data = returnData {
                    let results = Utilities.convertStringtoJSON(data as! String)
                    self.transcationData = Data()
                    for result: Dictionary<String, AnyObject> in results! {
                        let purchase = result["amount"] as! Double
                        let change = result["change"] as! Double
                        var description = result["description"] as! String
                        description = description.capitalizedString
                        let date = result["purchase_date"] as! String
                        let day = self.getDayString(date)
                        let month = self.getMonthString(date)
                        
                        
                        self.transcationData.amounts.append(purchase)
                        self.transcationData.change.append(change)
                        self.transcationData.descriptions.append(description)
                        self.transcationData.days.append(day)
                        self.transcationData.months.append(month)
                    }
                    
                    self.tableView.reloadData()
                }
            } else {
                print("Transactions Error = \(error)")
            }
        }
    }
    
    func getTotalsData() {
        PFCloud.callFunctionInBackground("getTotalSpendingChange", withParameters: ["object_id" : PFUser.currentUser()!.objectId!]) { (returnData: AnyObject?, error: NSError?) -> Void in
            if (error == nil) {
                if let data = returnData {
                    let results = Utilities.convertStringToDictionary(data as! String)
                    let spent = results!["total_spending"] as! Double
                    let saved = results!["total_change"] as! Double
                    
                    self.totalSpentLabel.text = "$\(Utilities.getCurrencyValue(spent))"
                    self.totalSavedLabel.text = "$\(Utilities.getCurrencyValue(saved))"
                    
                    let percentage = saved/100
                    self.carrotProgressView.setProgress(percentage, animated: true)
                    self.megaProgressView.setProgress(percentage, animated: true)
                }
            } else {
                print("Totals Error = \(error)")
            }
        }
    }

    
    // MARK: - Time
    
    func getDayString(time: String) -> String {
        
        // time format is "2016-01-08"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdDate: NSDate? = dateFormatter.dateFromString(time)
        
        let components = NSCalendar.currentCalendar().components(.Day, fromDate: createdDate!)
        
        let day = components.day
        return "\(day)"
        
    }
    
    func getMonthString(time: String) -> String {
        
        // time format is "2016-01-08"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdDate: NSDate? = dateFormatter.dateFromString(time)
        
        let components = NSCalendar.currentCalendar().components(.Month, fromDate: createdDate!)
        
        let month = components.month
        return "\(month)"
    }
    
}

    // MARK: - Data

struct Data {
    var amounts: [Double] = []
    var change: [Double] = []
    var days: [String] = []
    var months: [String] = []
    var descriptions: [String] = []
}