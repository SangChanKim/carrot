import UIKit
import Parse
import ParseUI
import LocalAuthentication

class LoginViewController : PFLogInViewController, PFSignUpViewControllerDelegate {
    
    //var backgroundImage : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let logo = UILabel()
        logo.text = "CARROT"
        logo.textColor = UIColor.orangeColor()
        logo.font = UIFont(name: "", size: 200)
        //logo.shadowColor = UIColor.lightGrayColor()
        //logo.shadowOffset = CGSizeMake(2, 2)
        logInView?.logo = logo
        
        let imageView = UIImageView(frame: CGRect(x: 140, y: 75, width: 100, height: 100))
        let carrotImage = UIImage(named: "Carrot_Logo")
        imageView.image = carrotImage
        
        self.view.addSubview(imageView)
        self.logInView?.usernameField!.text = "rickrickrick@gmail.com"
        self.logInView?.passwordField!.text = "what"
        
        let logo2 = UILabel()
        logo2.text = "CARROT"
        logo2.textColor = UIColor.orangeColor()
        logo2.font = UIFont(name: "HelveticaNeue-Light", size: 700)
        self.signUpController?.signUpView?.logo = logo
        self.signUpController?.signUpView?.backgroundColor = UIColor.whiteColor()
        
        showTouchId()
    }
    
    func showTouchId() {
        // Get the local authentication context.
        let context = LAContext()
        
        // Declare a NSError variable.
        var error: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        var reasonString = "Authentication is needed."
        
        // Check if the device can evaluate the policy.
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                
                if success {
                    
                }
                else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    print(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                        
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        
                    case LAError.UserFallback.rawValue:
                        print("User selected to enter custom password")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            //self.showPasswordAlert()
                        })
                        
                    default:
                        print("Authentication failed")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            //self.showPasswordAlert()
                        })
                    }
                }
                
            })]
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        //backgroundImage.frame = CGRectMake( 0,  0,  self.logInView!.frame.width,  self.logInView!.frame.height)
    }
    
}