//
//  MainWindow.swift
//  Duples
//
//  Created by Alberto Pasca on 10/02/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class MainWindow: NSWindowController {

    var vctrl : ViewController?

    @IBOutlet var toolbarBtnStart: NSToolbarItem!
    @IBOutlet var toolbarBtnStop:  NSToolbarItem!

    override func windowDidLoad() {
        self.window!.titleVisibility = .Hidden;

        toolbarBtnStart.enabled = true
        toolbarBtnStop.enabled  = false

        vctrl = self.contentViewController as? ViewController;
        vctrl!.mainWindow = self
    }

    @IBAction func toolbarStartPressed(sender: NSToolbarItem) {
//        vctrl!.toolbarStartPressed(sender)
    }

    @IBAction func toolbarStopPressed(sender: NSToolbarItem) {
//        vctrl!.toolbarStopPressed(sender)
    }
}
