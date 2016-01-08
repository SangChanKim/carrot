
import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var user_name: String = ""
    
    override func viewDidLoad() {
        print("didLoad\n")
        super.viewDidLoad()
        PFUser.logOut()
    }
    override func viewDidAppear(animated: Bool) {
        print("didAppear\n")
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword , .LogInButton , .PasswordForgotten , .SignUpButton]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("Logged in")
        
        getCustomerInfo()
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("showSetup", sender: self)
        //presentLoggedInAlert()
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to Carrot", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func getCustomerInfo() {
        PFCloud.callFunctionInBackground("getCustomerFromObjectId", withParameters: ["object_id" : PFUser.currentUser()!.objectId!]) { (returnData: AnyObject?, error: NSError?) -> Void in
            if (error == nil) {
                if let data = returnData {
                    let results = Utilities.convertStringToDictionary(data as! String)
                    let first_name = results!["first_name"] as! String
                    let last_name = results!["last_name"] as! String
                    
                    self.user_name = first_name + " " + last_name
                    self.performSegueWithIdentifier("showMain2", sender: self)
                }
            } else {
                print("Customer Error = \(error)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showMain2") {
            let destVC = segue.destinationViewController as! MainViewController
            destVC.goalName = PFUser.currentUser()!.objectForKey("goal_item") as! String
            destVC.goalPrice = PFUser.currentUser()!.objectForKey("goal_price") as! Double
            destVC.carrotName = PFUser.currentUser()!.objectForKey("carrot_item") as! String
            destVC.carrotPrice = PFUser.currentUser()!.objectForKey("carrot_price") as! Double
            destVC.username = user_name
        }
    }
    
}