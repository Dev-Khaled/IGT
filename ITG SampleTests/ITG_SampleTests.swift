//
//  ITG_SampleTests.swift
//  ITG SampleTests
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import XCTest
import ITG_Sample

class ITG_SampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformance() throws {
        measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) {
            // TODO: Khaled -> Test some functionality
        }
    }
    
    func testJSONDateFormatter() {
        let string = "2007-10-20T05:24:19Z"
        let date = DateFormatter.jsonDateFormatter.date(from: string)
        XCTAssertNotNil(date, "DateFormatter.jsonDateFormatter is wrong")
    }


}
