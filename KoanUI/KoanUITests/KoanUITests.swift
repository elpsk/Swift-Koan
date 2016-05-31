//
//  KoanUITests.swift
//  KoanUITests
//
//  Created by Alberto Pasca on 30/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import XCTest

class KoanUITests: XCTestCase {
    
    override func setUp()    { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testFiles() {
        let file = File()
        XCTAssertNotNil(file.dataFromFile(Constants.kJsonFileName, Constants.kJsonFileExt))

        let dict = file.dictionaryFromFile(Constants.kJsonFileName, Constants.kJsonFileExt)
        XCTAssertNotNil(dict)
    }

    func testTestFileOpen() {
        let file = File()
        let str = file.stringFromTestFile("/Volumes/DATA/Dropbox/Work/Personal/Koan-Swift/KoanTestcase/KoanTest/KoanTest.swift")

        XCTAssertNotNil(str)
    }

    func testConfiguration() {
        let config = Configuration()
        let dict = config.loadDataModel()
        XCTAssertNotNil(dict)
    }

    func testLoadCategories() {
        let config = Configuration()
        let dict = config.loadDataModel()

        XCTAssertNotNil(dict.valueForKey("categories"))

        print(dict.valueForKey("categories")?.allKeys)

        XCTAssertNotNil(config.loadAllCategories())
        XCTAssertGreaterThanOrEqual(config.loadAllCategories().count, 0)
    }

    func testLoadDetail() {
        let config = Configuration()
        let dict = config.loadDetailForCategory("Koans")
        XCTAssertNotNil(dict)
        print(dict)
    }

}


