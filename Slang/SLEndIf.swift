//
//  SLEndIf.swift
//  Slang
//
//  Created by Ipalibo Whyte on 19/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

class SLEndIf: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.953, green:0.612, blue:0.071, alpha:1)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
        }()
    
    lazy var lineNumber: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "Avenir", size: 14)
        return label
        }()
    
    lazy var condition: UITextField = {
        let condition = UITextField()
        condition.setTranslatesAutoresizingMaskIntoConstraints(false)
        condition.text = "END IF"
        condition.textColor = UIColor.whiteColor()
        condition.font = UIFont(name: "Avenir", size: 14)
        return condition
        }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        
        containerView.addSubview(condition)
        
        contentView.addSubview(lineNumber)
        contentView.addSubview(containerView)
        
        let views = [
            "container": containerView,
            "lineNumber": lineNumber,
            "nameLabel": condition
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-5-[lineNumber]-10-[container]-5-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[container]-5-|", options: nil, metrics: nil, views: views))
        
        contentView.addConstraint(NSLayoutConstraint(item: lineNumber, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
        contentView.addConstraint(NSLayoutConstraint(item: condition, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: condition, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
        
        // FIXME: - Put the colon in the center & put things relative to that
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
