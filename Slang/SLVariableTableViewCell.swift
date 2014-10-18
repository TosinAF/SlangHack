//
//  SLVariableTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 18/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

class SLVariableTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.290, green: 0.565, blue:0.886, alpha:1.0)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    lazy var lineNumber: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()

    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "VARIABLE"
        label.font = UIFont(name: "Avenir", size: 10)
        label.textColor = UIColor.whiteColor()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    lazy var nameLabel: UITextField = {
        let label = UITextField()
        label.text = "name"
        //label.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.28)
        //label.layer.cornerRadius = 10.0
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "FiraSans-Regular", size: 18)
        return label
    }()

    lazy var valueLabel: UITextField = {
        let label = UITextField()
        label.text = "value"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "FiraSans-Regular", size: 18)
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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None

        containerView.addSubview(typeLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(seperator)

        contentView.addSubview(lineNumber)
        contentView.addSubview(containerView)

        let views = [
            "container": containerView,
            "lineNumber": lineNumber,
            "typeLabel": typeLabel,
            "nameLabel": nameLabel,
            "valueLabel": valueLabel,
            "seperator": seperator
        ]

        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-5-[lineNumber]-10-[container]-5-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[container]-5-|", options: nil, metrics: nil, views: views))

        contentView.addConstraint(NSLayoutConstraint(item: lineNumber, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))

        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[typeLabel]", options: nil, metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[typeLabel]", options: nil, metrics: nil, views: views))

        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-95-[nameLabel]-5-[seperator]-10-[valueLabel]", options: .AlignAllCenterY, metrics: nil, views: views))

        contentView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))

        // FIXME: - Put the colon in the center & put things relative to that

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
