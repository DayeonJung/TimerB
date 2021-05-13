//
//  SelectOptionCell.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import UIKit

protocol OptionViewModelProtocol: class {
    var option: OptionModel { get }
    var valueDidChange: ((OptionViewModelProtocol) -> ())? { get set }
    var readyToShowAlertView: ((UIAlertController) -> ())? { get set }
    func valueButtonClicked()
   func setNumber(with number: Int)
}

class SelectOptionViewModel: OptionViewModelProtocol {
        
    var option: OptionModel {
        didSet {
            self.valueDidChange?(self)
        }
    }
    
    var valueDidChange: ((OptionViewModelProtocol) -> ())?
    var readyToShowAlertView: ((UIAlertController)->())?
    
    
    required init(model: OptionModel) {
        self.option = model
    }
    
    func setNumber(with number: Int) {
        self.option.setValue(with: number)
    }
    
    func valueButtonClicked() {
        let type = self.option.currentType()
        let title = type.korean + "을(를) 입력해주세요."
        let placeHolderMessage = String(1) + "~" + String(type.maxNumber) + type.unitName + " 입력 가능"
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.keyboardType = .numberPad
            tf.placeholder = placeHolderMessage
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
            
            let originalValue = self.option.currentValue()
            let input = alert.textFields?.first?.text ?? String(originalValue)
            let number = min(Int(input) ?? originalValue, type.maxNumber)
            self.setNumber(with: number)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.readyToShowAlertView?(alert)
    }
    
}

class SelectOptionCell: UICollectionViewCell {

    var viewModel: OptionViewModelProtocol! {
        didSet {
            self.viewModel.valueDidChange = { vm in
                self.optionView.setViewModel(with: vm.option)
            }
            
            self.viewModel.readyToShowAlertView = { alert in
                self.passAlertViewToController?(alert)
            }
        }
    }
    
    @IBOutlet weak var optionView: OptionControl!
    
    var passAlertViewToController: ((UIAlertController)->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        self.optionView.plusButton.onClick = {
            
            let original = self.viewModel.option.currentValue()
            let type = self.viewModel.option.currentType()
            
            if original < type.maxNumber {
                self.viewModel.setNumber(with: min(original + type.unit, type.maxNumber))
            }
        }
        
        self.optionView.minusButton.onClick = {
            
            let original = self.viewModel.option.currentValue()
            let type = self.viewModel.option.currentType()

            if original >= 1 {
                self.viewModel.setNumber(with: max(original - type.unit, 1))
            }
        }
        
        self.optionView.valueButton.addTarget(self,
                                              action: #selector(self.didClickValueButton),
                                              for: .touchUpInside)
        
    }
    
    @objc private func didClickValueButton() {
        self.viewModel.valueButtonClicked()
    }


    func setViewModel(with vm: SelectOptionViewModel) {
        self.viewModel = vm
        self.optionView.setViewModel(with: vm.option)
    }
    
}
