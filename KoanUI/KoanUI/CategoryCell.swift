//
//  CategoryCell.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class CategoryCell: NSTableCellView {

    @IBOutlet var titleLabel : NSTextField!
    @IBOutlet var progress: NSLevelIndicator!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
}

