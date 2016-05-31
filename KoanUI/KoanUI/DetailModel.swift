//
//  DetailModel.swift
//  KoanUI
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Cocoa

class DetailModel {

    var name : String!
    var completed : Bool = false

    init(name: String, completed: Bool) {
        self.name = name
        self.completed = completed
    }

}
