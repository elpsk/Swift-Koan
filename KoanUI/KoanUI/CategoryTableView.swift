//
//  CategoryTableView.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class CategoryTableView: NSTableView, NSTableViewDataSource, NSTableViewDelegate {

    var categories = NSArray()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.setDelegate(self)
        self.setDataSource(self)

        let config = Configuration()
        categories = config.loadAllCategories()
        if categories.count > 0 {
            self.reloadData()
        }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return categories.count
    }

    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeViewWithIdentifier("catIdx", owner: nil) as? CategoryCell {
            cell.titleLabel.stringValue = categories.objectAtIndex(row) as! String
            return cell
        }

        return nil
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        if ( self.selectedRow != -1 ) {
            NSNotificationCenter.defaultCenter().postNotificationName(Constants.kTableCategorySelected, object: categories[self.selectedRow])
        }
    }

}

