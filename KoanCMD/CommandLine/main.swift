//
//  main.swift
//  CommandLine
//
//  Created by Alberto Pasca on 17/05/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

import Foundation

class FileOperations {

    func openFile(fname:String, _ type:String) -> [String] {
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

    func openDirectFile(fPath:String) -> [String] {
        do {
            if let data : String = try String(contentsOfFile: fPath, encoding: NSUTF8StringEncoding) {
                return data.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            }
        }
        catch { return [] }
        return []
    }

    func readTestOutput() -> [String] {
        return openDirectFile( "/tmp/koad-output.txt" )
    }

    func testCounter( fname: String) -> Int {
        var counter = 0
        let lines   = openFile(fname, "swift")
        for line in lines {
            if line.containsString("//@XTPasky") {
                counter += 1
            }
        }
        return counter
    }

    func testNames( fname: String ) -> [String] {
        var names : [String] = []
        let lines   = openFile(fname, "swift")
        var add = false
        for line in lines {
            if add {
                add = !add
                names.append(line.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " ")))
            }
            if line.containsString("//@XTPasky") {
                if !add {
                    add = !add
                }
            }
        }
        return names
    }

}

class ReportParser {

    struct testReports {
        var tPassed : Int = 0
        var tFailed : Int = 0
        var tErrors : Int = 0
        var tTotals : Int = 0
    }

    func printResult( data:[String]! ) -> String {
        return data[data.count - 3]
    }

    func testPassed( data:[String]! ) -> Bool {
        return printResult(data).containsString("** TEST SUCCEEDED: ")
    }

    func details ( data:[String]! ) -> testReports {
        var result = printResult(data)
        result = result.substringFromIndex(result.rangeOfString(": ")!.endIndex)
        result = result.substringToIndex(result.rangeOfString(" total")!.endIndex)

        var cks = result.componentsSeparatedByString(", ")

        var report = testReports()
        report.tPassed = Int(cks[0].stringByReplacingOccurrencesOfString(" passed",  withString: ""))!
        report.tFailed = Int(cks[1].stringByReplacingOccurrencesOfString(" failed",  withString: ""))!
        report.tErrors = Int(cks[2].stringByReplacingOccurrencesOfString(" errored", withString: ""))!
        report.tTotals = Int(cks[3].stringByReplacingOccurrencesOfString(" total",   withString: ""))!

        return report
    }

    func detailsFailed ( data:[String]! ) -> [String] {
        var retVal : [String] = []
        let prefix = "    x "
        for line in data {
            if line.hasPrefix(prefix) {
                retVal.append(line.stringByReplacingOccurrencesOfString(prefix, withString: ""))
            }
        }
        return retVal
    }
}


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------


let fileOp : FileOperations = FileOperations()
let parser : ReportParser   = ReportParser()

let content : [String] = fileOp.readTestOutput()

print( "tot  : ", fileOp.testCounter("UnitTest") )
print( "tot  : ", fileOp.testCounter("TestZone") )
print( "names: ", fileOp.testNames("TestZone") )

print( parser.printResult(content) )
print( parser.testPassed(content) ? "PASSED!" : "FAILED!" )

var reports : ReportParser.testReports = parser.details(content)

print( "PASSED: ", reports.tPassed )
print( "FAILED: ", reports.tFailed )
print( "ERRORS: ", reports.tErrors )
print( "TOTALS: ", reports.tTotals )

let faileds = parser.detailsFailed(content)
for fail in faileds {
    print( "Test faileds: ", fail )
}




