//
//  SLForLoop.swift
//  Slang
//
//  Created by Ipalibo Whyte on 19/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

class SLForLoop: TableViewCell {

    var saveBlock: ((starts: String, ends: String, incrementBy: String) -> ())?

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.839, green:0.271, blue:0.255, alpha:1.0)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "FOR LOOP"
        label.font = UIFont(name: "Avenir", size: 10)
        label.textColor = UIColor.whiteColor()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    lazy var starts: UITextField = {
        let label = UITextField()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "0"
        label.delegate = self
        label.textColor = UIColor.whiteColor();
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()
    
    lazy var ends: UITextField = {
        let label = UITextField()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "5"
        label.delegate = self
        label.textColor = UIColor.whiteColor();
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()
    
    lazy var incrementBy: UITextField = {
        let label = UITextField()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "+1"
        label.delegate = self
        label.textColor = UIColor.whiteColor();
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()
    
    lazy var seperator: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "FiraSans-Regular", size: 18)
        return label
    }()
    
    lazy var seperator2: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "FiraSans-Regular", size: 18)
        return label
        }()
    
    lazy var lineNumber: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        type = BlockType.SLForLoop
        
        containerView.addSubview(typeLabel)
        containerView.addSubview(starts)
        containerView.addSubview(ends)
        containerView.addSubview(incrementBy)
        containerView.addSubview(seperator)
        containerView.addSubview(seperator2)
        
        contentView.addSubview(lineNumber)
        contentView.addSubview(containerView)
        
        let views = [
            "typeLabel": typeLabel,
            "container": containerView,
            "starts_TextView": starts,
            "ends_TextView": ends,
            "incrementBy": incrementBy,
            "lineNumber": lineNumber,
            "seperator": seperator
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-5-[lineNumber]-10-[container]-5-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[container]-5-|", options: nil, metrics: nil, views: views))
        
        contentView.addConstraint(NSLayoutConstraint(item: lineNumber, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[typeLabel]", options: nil, metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[typeLabel]", options: nil, metrics: nil, views: views))
        
        contentView.addConstraint(NSLayoutConstraint(item: starts, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: starts, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: -40))
        
        contentView.addConstraint(NSLayoutConstraint(item: seperator, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: seperator, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: -10))
        
        contentView.addConstraint(NSLayoutConstraint(item: ends, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: ends, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 20))
        
        contentView.addConstraint(NSLayoutConstraint(item: seperator2, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: seperator2, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 50))
        
        contentView.addConstraint(NSLayoutConstraint(item: incrementBy, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: incrementBy, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 80))
        
        // FIXME: - Put the colon in the center & put things relative to that
        
    }
    
    required override init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SLForLoop: UITextFieldDelegate {

    func textFieldDidEndEditing(textField: UITextField) {
        saveBlock?(starts: starts.text, ends: ends.text, incrementBy: incrementBy.text)
    }
}