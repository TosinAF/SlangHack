//
//  NoteViewController.swift
//  Slang
//
//  Created by Ipalibo Whyte on 19/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    lazy var saveNote: UIButton = {
        let noteBtn = UIButton()
        noteBtn .setTitle("Save", forState: UIControlState.Normal)
        noteBtn.titleLabel?.font = UIFont.systemFontOfSize(13);
        noteBtn.frame = CGRect(x:130, y:300, width:100, height:35)
        noteBtn.layer.cornerRadius = 5;
        noteBtn.backgroundColor = UIColor(red: 0.267, green:0.424, blue:0.702, alpha: 1)
        noteBtn.addTarget(self, action: Selector("saveAction"), forControlEvents: .TouchUpInside)

        return noteBtn
        }()


    lazy var myTextField: UITextField = {
        let label = UITextField()
        label.textAlignment = .Center
        label.textColor = UIColor.slangBrandColor()
        label.font = UIFont(name:"Avenir", size:18.0)
        label.placeholder  = "Your note"
        label.frame = CGRect(x:20, y:50, width:330, height:200)
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor .grayColor().CGColor
        label.textColor = UIColor.grayColor()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
        }()

    func saveAction()
    {
        println("saved")
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTextField)
        view.addSubview(saveNote)

        view.backgroundColor = UIColor .whiteColor()

    }
}
