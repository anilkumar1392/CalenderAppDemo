//
//  CalenderHelperTestCase.swift
//  Demo1Tests
//
//  Created by mac on 31/05/21.
//

import Foundation
import XCTest
@testable import Demo1

class CalenderHelperTestCase : XCTestCase {
    
    func test_withCurrentDate_fetchesDates(){
        let calenderObj = CalenderHelper()
        let numberOfDays = calenderObj.getDates(date: Date(), baseDate: Date())
        XCTAssertNotNil(numberOfDays, "No Data found")
    }
    
    func test_withCustomDate_fetchesDates(){
        let calenderObj = CalenderHelper()
        let date = Date().from(year: 2000, month: 12, day: 10)
        let numberOfDays = calenderObj.getDates(date: Date(), baseDate: date)
        XCTAssertNotNil(numberOfDays, "No Data found")
    }
    
    func test_withCustomDate_fetchesRightDates(){
        let calenderObj = CalenderHelper()
        let date = Date().from(year: 2000, month: 12, day: 10)
        let numberOfDays = calenderObj.getDates(date: Date(), baseDate: date)
        XCTAssertEqual(numberOfDays.count, 42)
    }
}
