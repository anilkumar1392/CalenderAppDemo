//
//  DayModel.swift
//  Demo1
//
//  Created by mac on 30/05/21.
//

import Foundation

struct Day {
  let date: Date
  let number: String
  let isSelected: Bool
  let isWithinDisplayedMonth: Bool
}

struct MonthMetadata {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}

struct InputDataModel{
    var month: Int?
    var year: Int?
}

extension InputDataModel {
    func validate() -> Bool {
        guard let month = month,month != 0 else {
            AlertController.showAlert(message: kEnterMonth)
            return false
        }
        
        guard let year = year,year != 0 else {
            AlertController.showAlert(message: kEnterYear)
            return false
        }
        if month > monthCount {
            AlertController.showAlert(message: kEnterValidMonth)
        } else if year <= yearMinValue {
            AlertController.showAlert(message: kMinSupportYear)
        } else {
            return true
        }
        return false
    }
}
