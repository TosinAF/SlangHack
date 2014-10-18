//
//  ViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 18/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.slangBrandColor()
        label.font = UIFont(name:"FiraSans-Regular", size:50.0)
        label.text  = "Slang"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(SLVariableTableViewCell.self, forCellReuseIdentifier: "blank")
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tableView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()

        view.addSubview(titleLabel)
        view.addSubview(tableView)

        let views = [
            "title": titleLabel,
            "tableView": tableView
        ]

        tableView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tableView(350)]", options: nil, metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[title]|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[title]-15-[tableView]", options: nil, metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[tableView]-20-|", options: nil, metrics: nil, views: views))
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - TableViewDataSource Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath) as SLVariableTableViewCell
        cell.lineNumber.text = "\(indexPath.row + 1)"
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
}

extension UIColor {

    class func slangBrandColor() -> UIColor {
        return UIColor(red: 0.937, green: 0.282, blue: 0.212, alpha: 1.0)
    }
}

