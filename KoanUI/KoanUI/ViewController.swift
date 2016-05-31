//
//  ViewController.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa
import OysterKit

class ViewController: NSViewController, NSTextStorageDelegate {

    @IBOutlet var detailDescription : NSTextField!
    @IBOutlet var scrollView : NSScrollView!
    @IBOutlet var scriptView : NSTextView!
    @IBOutlet var highlighter: TokenHighlighter!
    @IBOutlet var okScriptHighlighter: TokenHighlighter!

    var mainWindow : MainWindow?
    var lineNumberView : NoodleLineNumberView?
    var buildTokenizerTimer : NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()

        lineNumberView = MarkerLineNumberView(scrollView: scrollView)
        scrollView.verticalRulerView = lineNumberView
        scrollView.hasHorizontalRuler = false
        scrollView.hasVerticalRuler = true
        scrollView.rulersVisible = true

        scriptView.font = NSFont(name: "Anonymous Pro", size: 13)
        scriptView.textColor = NSColor.grayColor()

        highlighter.textStorage = scriptView.textStorage

        okScriptHighlighter.textStorage = tokenizerDefinitionTextView.textStorage
        okScriptHighlighter.textDidChange = {
            self.buildTokenizer()
        }

        okScriptHighlighter.tokenColorMap = [
            "loop" : NSColor.purpleColor(),
            "not" : NSColor.purpleColor(),
            "quote" : NSColor.quoteColor(),
            "Char" : NSColor.stringColor(),
            "single-quote" :NSColor.quoteColor(),
            "delimiter" : NSColor.stringColor(),
            "token" : NSColor.purpleColor(),
            "variable" : NSColor.variableColor(),
            "state-name" : NSColor.variableColor(),
            "start-branch" : NSColor.purpleColor(),
            "start-repeat" : NSColor.purpleColor(),
            "start-delimited" : NSColor.purpleColor(),
            "end-branch" :NSColor.purpleColor(),
            "end-repeat" : NSColor.purpleColor(),
            "end-delimited" : NSColor.purpleColor(),
            "tokenizer" : NSColor.redColor(),
            "exit-state" : NSColor.purpleColor(),
            "comments" : NSColor.commentColor()
        ]

        okScriptHighlighter.tokenizer = OKScriptTokenizer()

        prepareTextView(scriptView)
        prepareTextView(tokenizerDefinitionTextView)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(ViewController.updateDescriptionObserver(_:)),
            name: Constants.kTableDetailSelected, object: nil)
    }

    func updateDescriptionObserver( notification : NSNotification ) {
        let fname = notification.object as! String
        detailDescription.stringValue = fname

        let file = File()

        scriptView.string = file.stringFromTestFile(
        String(format: "%@/%@%@",
            "/Volumes/DATA/Dropbox/Work/Personal/Koan-Swift/KoanTestcase/KoanTest/",
            fname,
            ".swift"))

        doBuild()
    }

    func prepareTextView(view:NSTextView) {
        view.automaticQuoteSubstitutionEnabled  = false
        view.automaticSpellingCorrectionEnabled = false
        view.automaticDashSubstitutionEnabled   = false
        view.textStorage?.font = NSFont(name: "Anonymous Pro", size: 13.0)
    }

    var tokenizerDefinitionTextView : NSTextView {
        return scrollView.contentView.documentView as! NSTextView
    }

    func buildTokenizer() {
        if let timer = buildTokenizerTimer {
            timer.invalidate()
        }

        buildTokenizerTimer = NSTimer(timeInterval: 1.0, target: self, selector:#selector(ViewController.doBuild), userInfo: nil, repeats: false)
        NSRunLoop.mainRunLoop().addTimer(buildTokenizerTimer!, forMode: NSRunLoopCommonModes)
    }

    func doBuild() {
        highlighter.backgroundQueue.addOperationWithBlock(){
            if let newTokenizer:Tokenizer = OKStandard.parseTokenizer(self.tokenizerDefinitionTextView.string!) {
                self.highlighter.tokenizer = newTokenizer
            }
        }
    }

}


extension NSColor{
    class func quoteColor()->NSColor{
        return NSColor(calibratedRed: 0, green: 141/255, blue: 20/255, alpha: 1.0)
    }

    class func variableColor()->NSColor{
        return NSColor(calibratedRed: 0, green: 0.4, blue: 0.4, alpha: 1.0)
    }

    class func commentColor()->NSColor{
        return NSColor(calibratedRed: 0, green: 0.6, blue: 0, alpha: 1.0)
    }

    class func stringColor()->NSColor{
        return NSColor(calibratedRed: 0.5, green: 0.4, blue: 0.2, alpha: 1.0)
    }
}


