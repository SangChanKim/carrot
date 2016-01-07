
import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidAppear(animated: Bool) {
        PFUser.logOut()
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword , .LogInButton , .PasswordForgotten , .SignUpButton , .Facebook , .Twitter]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("Logged in")
        //presentLoggedInAlert()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("Signed up")
        //presentLoggedInAlert()
    }
    
}