//
//  CalenderCell.swift
//  Demo1
//
//  Created by mac on 30/05/21.
//

import UIKit

class CalenderCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!

    func configureCell(day : Day){
        dateLabel.text = day.number
        backgroundColor = day.isSelected ? AppUtility.RGBA(r: 229, g: 115, b: 41, a: 1.0) : .white
        dateLabel.textColor = day.isWithinDisplayedMonth ? .black : .lightGray
    }
}
