//
//  TestZone.swift
//  CommandLine
//
//  Created by Alberto Pasca on 17/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import XCTest

class TestZone : XCTestCase {

    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }

    //@XTPasky: sample description
    func testSum()
    {
        XCTAssertTrue(X.XY)
    }

    //@XTPasky:
    func testDiv()
    {
        XCTAssertTrue(X.XY)
    }

    //@XTPasky:
    func testBasicIf()
    {
        var x : Int = 1
        if (true) {
            x += 1;
        }
        XCTAssertEqual(x, X.XX)
    }

}
