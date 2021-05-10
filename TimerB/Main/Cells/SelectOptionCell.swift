//
//  SelectOptionCell.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import UIKit

protocol OptionViewModelProtocol {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        self.optionView.plusButton.onClick = {
            
            let original = self.viewModel.option.currentValue()
            let unit = self.viewModel.option.currentType() == .Player ? 1 : 5

            let maxNum = self.viewModel.option.currentType() == .Player ? 9 : 99
            
            if original < maxNum {
                self.viewModel.setNumber(with: min(original + unit, 99))
            }
        }
        
        self.optionView.minusButton.onClick = {
            
            let original = self.viewModel.option.currentValue()
            let unit = self.viewModel.option.currentType() == .Player ? 1 : 5

            if original >= 1 {
                self.viewModel.setNumber(with: max(original - unit, 1))
            }
        }
        
    }

    func setViewModel(with vm: SelectOptionViewModel) {
        self.viewModel = vm
        self.optionView.setViewModel(with: vm.option)
    }
    
}
