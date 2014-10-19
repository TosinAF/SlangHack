//
//  ViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 18/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit
import JavaScriptCore

typealias ID = AnyObject!

enum BlockType: Int {
    case SLBlankLine = 0, SLVariable, SLForLoop, SLIF, SLELIF, SLEndIF, SLElse, SLPrint
}

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
        tableView.registerClass(SLBlankLineTableViewCell.self, forCellReuseIdentifier: "blank")
        tableView.registerClass(SLVariableTableViewCell.self, forCellReuseIdentifier: "variable")
        tableView.registerClass(SLIfCondition.self, forCellReuseIdentifier: "if")
        tableView.registerClass(SLElseIf.self, forCellReuseIdentifier: "elseif")
        tableView.registerClass(SLElse.self, forCellReuseIdentifier: "else")
        tableView.registerClass(SLEndIf.self, forCellReuseIdentifier: "endif")
        tableView.registerClass(SLForLoop.self, forCellReuseIdentifier: "loop")
        tableView.registerClass(SLPrint.self, forCellReuseIdentifier: "print")
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tableView
    }()

    var ipTypes = [BlockType]()
    var values = [[String: AnyObject]]()

    lazy var blocksContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    let variableFrame = CGRectMake(20, 30, 90, 30);
    let printFrame = CGRectMake(20, 100, 90, 30);
    let elseFrame = CGRectMake(150, 30, 90, 30);
    let elseifFrame = CGRectMake(150, 100, 90, 30);
    let endifFrame = CGRectMake(270, 30, 90, 30);
    let forloopFrame = CGRectMake(270, 100, 90, 30);
    let ifFrame = CGRectMake(20, 170, 90, 30);

    lazy var printBlock: UILabel = {
        let label = UILabel(frame: self.printFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "PRINT"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
    }()

    lazy var variableBlock: UILabel = {
        let label = UILabel(frame: self.variableFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "VARIABLE"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
        }()

    lazy var forloopBlock: UILabel = {
        let label = UILabel(frame: self.forloopFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "FOR LOOP"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
        }()

    lazy var ifBlock: UILabel = {
        let label = UILabel(frame: self.ifFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "IF"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
        }()

    lazy var elseifBlock: UILabel = {
        let label = UILabel(frame: self.elseifFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "ELSE IF"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
        }()

    lazy var endifBlock: UILabel = {
        let label = UILabel(frame: self.endifFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "END IF"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
        }()

    lazy var elseBlock: UILabel = {
        let label = UILabel(frame: self.elseFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont(name:"FiraSans-Regular", size:18.0)
        label.text  = "ELSE"
        label.userInteractionEnabled = true
        label.enableDragging()
        label.setDraggable(true)
        return label
        }()

    lazy var context: JSContext = {
        let context = JSContext(virtualMachine: JSVirtualMachine())
        return context
    }()

    var log: [AnyObject] = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()

        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(blocksContainer)

        blocksContainer.addSubview(printBlock)
        blocksContainer.addSubview(variableBlock)
        blocksContainer.addSubview(elseBlock)
        blocksContainer.addSubview(elseifBlock)
        blocksContainer.addSubview(endifBlock)
        blocksContainer.addSubview(forloopBlock)
        blocksContainer.addSubview(ifBlock)

        let views = [
            "title": titleLabel,
            "tableView": tableView,
            "blocksContainer": blocksContainer,
        ]

        for i in 0..<8 {
            values.append([String: AnyObject]())
        }

        for i in 0..<8 {
            ipTypes.append(BlockType.SLBlankLine)
        }

        tableView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tableView(280)]", options: nil, metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[title]|", options: nil, metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[title]-15-[tableView]", options: nil, metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[tableView]-20-|", options: nil, metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[blocksContainer]|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[blocksContainer]|", options: nil, metrics: nil, views: views))

        blocksContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[blocksContainer(220)]", options: nil, metrics: nil, views: views))

        context.evaluateScript("var console = {};")

        context.store("console", sKey: "log") { (o:ID)->ID in
            println("\(o)")
            return nil
        }

        forloopBlock.setPanGestureEndedAction { (view) -> Void in
            let v = view as UILabel

            let cells = self.tableView.visibleCells()

            let vFrame = self.blocksContainer.convertRect(v.frame, toView: self.view)

            for cell in cells {

                let cFrame = self.tableView.convertRect(cell.frame, toView: self.view)

                if(CGRectIntersectsRect(cFrame, vFrame)) {
                    let ip = self.tableView.indexPathForCell(cell as UITableViewCell)
                    print(ip!.row)

                    switch(v.text!) {
                    case "VARIABLE":
                        self.ipTypes[ip!.row] = .SLVariable
                        view.frame = self.variableFrame
                        self.tableView.reloadData()
                        return
                    case "ELSE":
                        self.ipTypes[ip!.row] = .SLElse
                        view.frame = self.elseFrame
                        self.tableView.reloadData()
                        return
                    case "END IF":
                        self.ipTypes[ip!.row] = .SLEndIF
                        view.frame = self.endifFrame
                        self.tableView.reloadData()
                        return
                    case "PRINT":
                        self.ipTypes[ip!.row] = .SLPrint
                        view.frame = self.printFrame
                        self.tableView.reloadData()
                        return
                    case "ELSE IF":
                        self.ipTypes[ip!.row] = .SLELIF
                        view.frame = self.elseifFrame
                        self.tableView.reloadData()
                        return
                    case "FOR LOOP":
                        self.ipTypes[ip!.row] = .SLForLoop
                        view.frame = self.forloopFrame
                        self.tableView.reloadData()
                        return
                    case "IF":
                        self.ipTypes[ip!.row] = .SLIF
                        view.frame = self.ifFrame
                        self.tableView.reloadData()
                        return
                    default:
                        view.frame = self.endifFrame
                        return
                    }
                }
            }
        }
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

        let type = ipTypes[indexPath.row]
        var value = values[indexPath.row]

        switch (type) {

        case .SLBlankLine:
            let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath) as SLBlankLineTableViewCell
            cell.lineNumber.text = "\(indexPath.row + 1)"
            return cell
        case .SLVariable:
            let cell = tableView.dequeueReusableCellWithIdentifier("variable", forIndexPath: indexPath) as SLVariableTableViewCell
            cell.lineNumber.text = "\(indexPath.row + 1)"

            if let name: AnyObject = value["name"] {
                let n = name as String
                cell.nameLabel.text = n
            }

            if let val: AnyObject = value["value"] {
                let v = val as String
                cell.valueLabel.text = v
            }

            cell.saveBlock = { (name, v) in
                value["name"] = name
                value["value"] = v
            }

            return cell

        case .SLForLoop:
            let cell = tableView.dequeueReusableCellWithIdentifier("loop", forIndexPath: indexPath) as SLForLoop
            cell.lineNumber.text = "\(indexPath.row + 1)"

            if let start: AnyObject = value["start"] {
                let s = start as String
                cell.starts.text = s
            }

            if let stop: AnyObject = value["stop"] {
                let s = stop as String
                cell.ends.text = s
            }

            if let inc: AnyObject = value["inc"] {
                let i = inc as String
                cell.incrementBy.text = i
            }

            cell.saveBlock = { (starts, ends, inc) in
                value = [String: AnyObject]()
                value["start"] = starts
                value["stop"] = ends
                value["inc"] = inc
            }

            return cell

        case .SLIF:
            let cell = tableView.dequeueReusableCellWithIdentifier("if", forIndexPath: indexPath) as SLIfCondition
            cell.lineNumber.text = "\(indexPath.row + 1)"

            if let cond: AnyObject = value["cond"] {
                let c = cond as String
                cell.condition.text = c
            }

            cell.saveBlock = { (cond) in
                value = [String: AnyObject]()
                value["cond"] = cond
            }

            return cell
        case .SLELIF:
            let cell = tableView.dequeueReusableCellWithIdentifier("elseif", forIndexPath: indexPath) as SLElseIf
            cell.lineNumber.text = "\(indexPath.row + 1)"

            if let cond: AnyObject = value["condd"] {
                let c = cond as String
                cell.condition.text = c
            }

            cell.saveBlock = { (cond) in
                value = [String: AnyObject]()
                value["condd"] = cond
            }

            return cell
        case .SLElse:
            let cell = tableView.dequeueReusableCellWithIdentifier("else", forIndexPath: indexPath) as SLElse
            cell.lineNumber.text = "\(indexPath.row + 1)"

            if let cond: AnyObject = value["conddd"] {
                let c = cond as String
                cell.condition.text = c
            }

            cell.saveBlock = { (cond) in
                value = [String: AnyObject]()
                value["conddd"] = cond
            }

            return cell
        case .SLPrint:
            let cell = tableView.dequeueReusableCellWithIdentifier("print", forIndexPath: indexPath) as SLPrint
            cell.lineNumber.text = "\(indexPath.row + 1)"

            if let msg: AnyObject = value["msg"] {
                let m = msg as String
                cell.printText.text = m
            }

            cell.saveBlock = { (text) in
                value = [String: AnyObject]()
                value["msg"] = text
            }

            return cell

        case .SLEndIF:
            let cell = tableView.dequeueReusableCellWithIdentifier("endif", forIndexPath: indexPath) as SLEndIf
            cell.lineNumber.text = "\(indexPath.row + 1)"
            return cell

        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath) as SLBlankLineTableViewCell
            cell.lineNumber.text = "\(indexPath.row + 1)"
            return cell

        }

    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
}

extension RootViewController {
    func executeJS(code: String) {
        let result = context.evaluateScript(code)
    }
}

extension UIColor {

    class func slangBrandColor() -> UIColor {
        return UIColor(red: 0.937, green: 0.282, blue: 0.212, alpha: 1.0)
    }
}

extension JSContext {

    // possibly use subscripting?

    func fetch(key:NSString)->JSValue {
        return getJSVinJSC(self, key)
    }
    func store(key:NSString, _ val:ID) {
        setJSVinJSC(self, key, val)
    }
    func store(key:NSString, _ blk:()->ID) {
        setB0JSVinJSC(self, key, blk)
    }
    func store(key:NSString, _ blk:(ID)->ID) {
        setB1JSVinJSC(self, key, blk)
    }
    func store(key:NSString, _ blk:(ID,ID)->ID) {
        setB2JSVinJSC(self, key, blk)
    }
    func store(key:NSString, sKey: NSString, _ blk:(ID)->ID) {
        setB3JSVinJSC(self, key, sKey, blk)
    }
}

