//
//  CalenderHelper.swift
//  Demo1
//
//  Created by mac on 30/05/21.
//

import Foundation

class CalenderHelper : NSObject {

    // MARK: Calendar Data Values
    
    private let calendar = Calendar(identifier: .gregorian)
    private var selectedDate: Date = Date()
    private var baseDate: Date = Date()
    
    func getDates(date : Date,baseDate : Date) -> [Day] {
        self.selectedDate = date
        self.baseDate = baseDate
        return generateDaysInMonth(for: baseDate)
    }
}

// MARK: - Day Generation
private extension CalenderHelper {

    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
      guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month,for: baseDate)?.count, let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
          throw CalendarDataError.metadataGeneration
        }

      let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
      return MonthMetadata(numberOfDays: numberOfDaysInMonth,firstDay: firstDayOfMonth,firstDayWeekday: firstDayWeekday)
    }

    func generateDaysInMonth(for baseDate: Date) -> [Day] {
      guard let metadata = try? monthMetadata(for: baseDate) else {
        return []
      }

      let numberOfDaysInMonth = metadata.numberOfDays
      let offsetInInitialRow = metadata.firstDayWeekday
      let firstDayOfMonth = metadata.firstDay

      var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map { day in
          let isWithinDisplayedMonth = day >= offsetInInitialRow
          let dayOffset = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)
          return generateDay(offsetBy: dayOffset,for: firstDayOfMonth,isWithinDisplayedMonth: isWithinDisplayedMonth)
        }

      days += generateStartOfNextMonth(using: firstDayOfMonth)
      return days
    }

    func generateDay(offsetBy dayOffset: Int,for baseDate: Date,isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date( byAdding: .day,value: dayOffset,to: baseDate) ?? baseDate
        return Day( date: date,number: date.stringFromDate(),isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
        isWithinDisplayedMonth: isWithinDisplayedMonth
      )
    }

    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
      guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),to: firstDayOfDisplayedMonth) else {
          return []
      }
      let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
      guard additionalDays > 0 else {
        return []
      }
      let days: [Day] = (1...additionalDays).map {generateDay(offsetBy: $0,for: lastDayInMonth,isWithinDisplayedMonth: false)}
      return days
    }

    enum CalendarDataError: Error {
      case metadataGeneration
    }

  }

