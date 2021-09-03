//
//  CalenderAdapter.swift
//  Demo1
//
//  Created by mac on 31/05/21.
//

import Foundation

struct CalenderDataAdapter : MonthService {
    let calenderHelper : CalenderHelper

    func getMonthData(baseDate : Date,onComplition: @escaping ([Day]) -> Void) {
        let days = calenderHelper.getDates(date: Date(), baseDate: baseDate)
        onComplition(days)
    }

}
