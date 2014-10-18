//
//  EmptyTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 18/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

class SLBlankLineTableViewCell: UITableViewCell {

    lazy var lineNumber: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()

    lazy var blankView: UIView = {
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.grayColor()
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None

        contentView.addSubview(lineNumber)
        contentView.addSubview(blankView)

        let views = [
            "lineNumber": lineNumber,
            "blankView": blankView
        ]

        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-5-[lineNumber]-10-[blankView]-5-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[blankView]-5-|", options: nil, metrics: nil, views: views))
        contentView.addConstraint(NSLayoutConstraint(item: lineNumber, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
