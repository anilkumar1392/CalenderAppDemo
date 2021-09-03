//
//  CalenderVCTests.swift
//  Demo1Tests
//
//  Created by mac on 31/05/21.
//

import Foundation
import XCTest
@testable import Demo1

class CalenderVCTest : XCTestCase {
    
    func test_viewDidLoad_dateHeaderLabel(){
        let sut = makeSut()
        XCTAssertEqual(sut.monthLabel.text, Date().monthYearFromDate())
    }
    
    func test_viewDidLoad_withNoData_showsDefaultCurrentMonthData(){
        let sut = makeSut()
        var day : [Day] = []
        let service = CalenderDataAdapter(calenderHelper: CalenderHelper())
        service.getMonthData(baseDate: Date()) {(days) in
            day = days
        }
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), day.count)
    }
    
    func test_viewDidLoad_withNoData_showsShowsCurrentSelectedDate(){
        let sut = makeSut()
        var selectedDay : Day?
        let service = CalenderDataAdapter(calenderHelper: CalenderHelper())
        service.getMonthData(baseDate: Date()) {(days) in
            selectedDay = days.filter({$0.isSelected}).first
        }
        XCTAssertEqual(sut.days.filter({$0.isSelected}).first?.number, selectedDay?.number)
    }
    
    func test_viewDidLoad_withDateProvided_showsSelectedMonthAndYear(){

        let inputDateMonth = InputDataModel(month: 12, year: 2000)
        let sut = makeSut(date: Date(), inputDataModel: inputDateMonth)
        sut.showSelectedDateData()

        var day : [Day] = []
        let service = CalenderDataAdapter(calenderHelper: CalenderHelper())
        let date = Date().from(year: 2000, month: 12, day: 10)
        service.getMonthData(baseDate: date) {(days) in
            day = days
        }
        
        XCTAssertEqual(sut.days.count, day.count)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), day.count)
        XCTAssertEqual(sut.monthLabel.text, date.monthYearFromDate())
        XCTAssertEqual(sut.baseDate?.monthYearFromDate(), date.monthYearFromDate())

    }
    
    func makeSut(date : Date = Date(), inputDataModel : InputDataModel = InputDataModel()) -> CalenderVC {
        let sut = CalenderViewComposer.viewComposedWith(date, inputDataModel)
        _ = sut.view
        return sut
    }
}
