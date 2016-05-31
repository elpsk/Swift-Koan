//
//  DetailTableView.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class DetailTableView: NSTableView, NSTableViewDataSource, NSTableViewDelegate {

    var details = NSMutableDictionary()
    let config = Configuration()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.setDelegate(self)
        self.setDataSource(self)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetailTableView.updateTableModelObserver(_:)), name: Constants.kTableCategorySelected, object: nil)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }

    func updateTableModelObserver( notification : NSNotification ) {
        details = config.loadDetailForCategory(notification.object as! String)
        if details.count > 0 {
            self.reloadData()
        }
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return details.count
    }

    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeViewWithIdentifier("detailIdx", owner: nil) as? DetailCell {
            cell.titleLabel.stringValue = details.allKeys[row] as! String
            return cell
        }

        return nil
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        if ( self.selectedRow != -1 ) {
            NSNotificationCenter.defaultCenter().postNotificationName(
                Constants.kTableDetailSelected,
                object: details.allValues[self.selectedRow])
        }
    }

}
