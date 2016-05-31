//
//  CategoryModel.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class CategoryModel {

    var name : String!
    var percentageCompletion : Int = 0

    init(name: String, completion: Int) {
        self.name = name
        self.percentageCompletion = completion
    }

}
