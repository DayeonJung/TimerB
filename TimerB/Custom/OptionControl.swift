//
//  OptionControl.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/04.
//

import UIKit

enum Option: String {
    case Time
    case Player
}

struct OptionModel {
    let type: Option
    private var value: Int
    
    init(type: Option, value: Int) {
        self.type = type
        self.value = value
    }
    
    func currentValue() -> Int {
        return self.value
    }
    
    mutating func setValue(with number: Int) {
        self.value = number
    }

}

class OptionControl: UIView {

    private var viewModel: OptionModel? {
        didSet {
            self.setUI()
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var minusButton: IconButton!
    @IBOutlet weak var plusButton: IconButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }

    private func commoninit() {
         let superView = Bundle.main.loadNibNamed("OptionControl", owner: self, options: nil)?.first as! UIView
         self.addSubview(superView)
         superView.frame = self.bounds
         superView.layoutIfNeeded()
         
        self.minusButton.setModel(with: IconButtonModel(imageName: "minus"))
        self.plusButton.setModel(with: IconButtonModel(imageName: "plus"))
     }
    
    func setViewModel(with viewModel: OptionModel) {
        self.viewModel = viewModel
    }
    
    private func setUI() {
        self.titleLable.text = self.viewModel?.type.rawValue
        self.valueLabel.text = String(self.viewModel?.currentValue() ?? 0)
    }
    
}
