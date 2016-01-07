import UIKit
import Parse
import ParseUI

class LoginViewController : PFLogInViewController {
    
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
        
        
        // set our custom background image
        //backgroundImage = UIImageView(image: UIImage(named: "welcome_bg"))
        //backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        //self.logInView!.insertSubview(backgroundImage, atIndex: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        //backgroundImage.frame = CGRectMake( 0,  0,  self.logInView!.frame.width,  self.logInView!.frame.height)
    }
    
}