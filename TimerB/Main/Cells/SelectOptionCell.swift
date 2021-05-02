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
    func setNumber(with number: Int)
}

class SelectOptionViewModel: OptionViewModelProtocol {
        
    var option: OptionModel {
        didSet {
            self.valueDidChange?(self)
        }
    }
    
    var valueDidChange: ((OptionViewModelProtocol) -> ())?
    
    required init(model: OptionModel) {
        self.option = model
    }
    
    func setNumber(with number: Int) {
        self.option.setValue(with: number)
    }
}

class SelectOptionCell: UICollectionViewCell {

    var viewModel: OptionViewModelProtocol! {
        didSet {
            self.viewModel.valueDidChange = { vm in
                self.optionView.setViewModel(with: vm.option)
            }
        }
    }
    
    @IBOutlet weak var optionView: OptionControl!
    var didClickValueButton: ((UIAlertController)->())?
    
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
        
        self.optionView.valueButton.addTarget(self, action: #selector(valueButtonClicked), for: .touchUpInside)
        
    }
    
    @objc private func valueButtonClicked() {
        
        let type = self.viewModel.option.currentType()
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
            
            let originalValue = self.viewModel.option.currentValue()
            let input = alert.textFields?.first?.text ?? String(originalValue)
            let number = min(Int(input) ?? originalValue, type.maxNumber)
            self.viewModel.setNumber(with: number)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.didClickValueButton?(alert)

    }

    func setViewModel(with vm: SelectOptionViewModel) {
        self.viewModel = vm
        self.optionView.setViewModel(with: vm.option)
    }
    
}
