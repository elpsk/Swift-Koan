//
//  File.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class File {

    func stringFromTestFile(fPath:String) -> String? {
        if let data : NSData = NSData(contentsOfFile: fPath) {
            return String(data: data, encoding: NSUTF8StringEncoding)
        }
        return nil
    }

    func stringFromFile(fname:String, _ type:String) -> String? {
        if let path = NSBundle.mainBundle().pathForResource(fname, ofType: type) {
            if let data : NSData = NSData(contentsOfFile: path) {
                return String(data: data, encoding: NSUTF8StringEncoding)
            }
        }

        return nil
    }

    func dataFromFile(fname:String, _ type:String) -> NSData? {
        if let path = NSBundle.mainBundle().pathForResource(fname, ofType: type) {
            if let data : NSData = NSData(contentsOfFile: path) {
                return data
            }
        }

        return nil
    }

    func arrayFromFile(fname:String, _ type:String) -> [String] {
        if let path = NSBundle.mainBundle().pathForResource(fname, ofType: type) {
            do {
                if let data : String = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding) {
                    return data.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
                }
            }
            catch { return [] }
        }

        return []
    }

    func dictionaryFromFile(fname:String, _ type:String) -> NSDictionary {
        if let data = dataFromFile(fname, type) {
            do {
                if let json : AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) {
                    return json as! NSDictionary
                }
            }
            catch { }
        }

        return NSDictionary()
    }
}
