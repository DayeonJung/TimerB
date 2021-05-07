//
//  SettingContentView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

class SettingContentView: UIView {

    @IBOutlet weak var blurView: BlurEffectView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    
    private func commoninit() {
        let superView = Bundle.main.loadNibNamed("SettingContentView", owner: self, options: nil)?.first as! UIView
        self.addSubview(superView)
        superView.frame = self.bounds
        superView.layoutIfNeeded()
        
    }
    
    
    func setBlur(with value: CGFloat) {
        self.blurView.animator.fractionComplete = value
    }
    
}
