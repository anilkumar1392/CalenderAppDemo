//
//  CalenderVC.swift
//  Demo1
//
//  Created by mac on 30/05/21.
//

import UIKit

protocol MonthService {
    func getMonthData(baseDate: Date, onComplition: @escaping ([Day]) -> Void)
}

class CalenderVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var showBtn: UIButton!
    
    //MARK: - Properties
    var days : [Day] = []
    var baseDate : Date?
    var inputDataModel : InputDataModel?

    var monthService : MonthService?
    
    //MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        getMonthData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutCollectionView()
    }

    //MARK: - Helper methods
    func setupView(){
        showBtn.layer.cornerRadius = 6.0
        showBtn.setTitle(kShow, for: .normal)
        layoutCollectionView()
    }
    
    func layoutCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.dataSource = self
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: (self.collectionView.frame.width)/7, height: 40)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .vertical
            self.collectionView.collectionViewLayout = layout
            self.collectionView.reloadData()
            self.collectionView.isScrollEnabled = false
        }
    }

}

//MARK: - Button actions
extension CalenderVC {
    @IBAction func showBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if inputDataModel?.validate() == true {
            showSelectedDateData()
        }
    }
}

//MARK: - UITextFieldDelegate
extension CalenderVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == monthTextField {
            inputDataModel?.month = Int(textField.text ?? "0")
        } else {
            inputDataModel?.year = Int(textField.text ?? "0")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            if textField == monthTextField {
                return Int(updatedText) ?? 0 <= monthCount
            } else {
                return updatedText.count > yearMaxLength ? false : true
            }
        }
        return true
    }
}

//MARK: - UICollectionViewDataSource
extension CalenderVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CalenderCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureCell(day: days[indexPath.item])
        return cell
    }
}

//MARK: - Get data
extension CalenderVC {
    func getMonthData() {
        monthService?.getMonthData(baseDate: baseDate ?? Date(), onComplition: handleResult(days:))
    }
    
    func handleResult(days : [Day]){
        self.days = days
        showMonthData()
        collectionView.reloadData()
    }
}

//MARK: - Show data
extension CalenderVC {
    func showSelectedDateData(){
        guard let month = inputDataModel?.month else {return}
        guard let year = inputDataModel?.year else {return}
        baseDate = Date().from(year: year, month: month, day: 10)
        getMonthData()
        monthTextField.text = ""
        yearTextField.text = ""
    }
    
    func showMonthData(){
        monthLabel.text = baseDate?.monthYearFromDate()
    }
}
