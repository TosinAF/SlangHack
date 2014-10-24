//
//  SLLogin.swift
//  Slang
//
//  Created by Ipalibo Whyte on 19/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit


class SLLogin: UIViewController{
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.slangBrandColor()
        label.font = UIFont(name:"FiraSans-Regular", size:50.0)
        label.text  = "Slang"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
        }()
    
    lazy var myLogin: UIButton = {
        let label = UIButton()
        label.backgroundColor = UIColor(red: 0.529, green:0.827, blue:0.486, alpha:1)
        label.frame = CGRect(x:60, y:300, width:250, height:40)
        label.setTitle("Login with Evernote", forState: UIControlState.Normal)
        label.addTarget(self, action: Selector("buttonAction"), forControlEvents: .TouchUpInside)
        label.layer.cornerRadius = 5;
        return label
        }()
    
    
    lazy var homeViewController: RootViewController = {
        let homeViewController = RootViewController()
        return homeViewController
        }()
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor();
        view.addSubview(titleLabel)
        view.addSubview(myLogin)
        
        
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
         view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: -200))
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func buttonAction()
    {
        
        let session = ENSession.sharedSession()
        
        session.unauthenticate()
        
        session .authenticateWithViewController(self, preferRegistration: false) { (error) -> Void in
            if (error != nil)
            {
                print("Unsuccessful");
                self.navigationController?.pushViewController(self.homeViewController, animated: true)
                
            }else{
                print("Successful");
                self.navigationController?.pushViewController(self.homeViewController, animated: true)
            }
        }

    }


    
}