//
//  SignUpController.swift
//  Carrot
//
//  Created by Sang Chan Kim on 1/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//


import ParseUI

class SignUpViewController : PFSignUpViewController {
    
    var backgroundImage : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.view.backgroundColor = UIColor.whiteColor()
        
        let logo = UILabel()
        logo.text = "CARROT"
        logo.textColor = UIColor.orangeColor()
        logo.font = UIFont(name: "HelveticaNeue-Light", size: 200)
        //logo.shadowColor = UIColor.lightGrayColor()
        //logo.shadowOffset = CGSizeMake(2, 2)
        signUpView?.logo = logo
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // stretch background image to fill screen
//        backgroundImage.frame = CGRectMake( 0,  0,  signUpView!.frame.width,  signUpView!.frame.height)
//        
//        // position logo at top with larger frame
//        signUpView!.logo!.sizeToFit()
//        let logoFrame = signUpView!.logo!.frame
//        signUpView!.logo!.frame = CGRectMake(logoFrame.origin.x, signUpView!.usernameField!.frame.origin.y - logoFrame.height - 16, signUpView!.frame.width,  logoFrame.height)
//    }
    
}