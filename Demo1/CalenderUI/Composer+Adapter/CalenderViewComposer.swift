//
//  CalenderViewComposer.swift
//  Demo1
//
//  Created by mac on 30/05/21.
//

import Foundation
import UIKit

public final class CalenderViewComposer {
    private init() {}
    
    static func viewComposedWith(_ baseDate: Date = Date(),_ inputDataModel: InputDataModel = InputDataModel()) -> CalenderVC{
        let calenderVC = CalenderVC.make()
        calenderVC.baseDate = baseDate
        calenderVC.inputDataModel = inputDataModel
        calenderVC.monthService = CalenderDataAdapter(calenderHelper: CalenderHelper())
        return calenderVC
    }
}

extension CalenderVC {
    static func make() -> CalenderVC {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let calenderVC = storyboard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        return calenderVC
    }
}
