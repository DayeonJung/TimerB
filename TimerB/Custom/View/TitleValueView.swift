//
//  TitleValueView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/09.
//

import Foundation
import UIKit

@IBDesignable
class TitleValueView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }

    private func commoninit() {
        let bundle = Bundle(for: TitleValueView.self)
         let superView = bundle.loadNibNamed("TitleValueView", owner: self, options: nil)?.first as! UIView
         self.addSubview(superView)
         superView.frame = self.bounds
         superView.layoutIfNeeded()
        
     }
    
    func setUI(title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
}
