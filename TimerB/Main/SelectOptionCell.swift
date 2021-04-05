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
        self.option.value = number
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
            let original = self.viewModel.option.value
            if original < 99 {
                self.viewModel.setNumber(with: original + 1)
            }
        }
        
        self.optionView.minusButton.onClick = {
            let original = self.viewModel.option.value
            if original >= 1 {
                self.viewModel.setNumber(with: original - 1)
            }
        }
        
    }

    func setViewModel(with vm: SelectOptionViewModel) {
        self.viewModel = vm
        self.optionView.setViewModel(with: vm.option)
    }
    
}
