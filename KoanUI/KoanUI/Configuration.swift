//
//  Configuration.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class Configuration {

    func loadDataModel() -> NSDictionary {
        return File().dictionaryFromFile(Constants.kJsonFileName, Constants.kJsonFileExt)
    }

    func loadAllCategories() -> [String] {
        let categories = loadDataModel()
        return (categories.valueForKey("categories")?.allKeys)!
    }

    func loadDetailForCategory(category : String) -> NSMutableDictionary {
        let categories = loadDataModel()
        let array = (categories.valueForKeyPath(String(format: "categories.%@", category)) as? NSArray)!

        let retDict = NSMutableDictionary()
        for item in array {
            let key = (item as! NSDictionary).allKeys[0] as! String
            let val = (item as! NSDictionary).allValues[0] as! String

            retDict.setValue(val, forKey: key)
        }

        return retDict
    }

}
