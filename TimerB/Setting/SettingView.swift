//
//  SettingView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/25.
//

import UIKit


class SettingView: UIView {

    private var blurView = BlurEffectView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    private func commoninit() {
        let superView = Bundle.main.loadNibNamed("SettingView", owner: self, options: nil)?.first as! UIView
        self.addSubview(superView)
        superView.frame = self.bounds
        superView.layoutIfNeeded()
        
        self.blurView.frame = self.bounds
        self.addSubview(self.blurView)
        
    }
    
    func adjustAlphaOfBlurView(alpha: CGFloat) {
        // alpha 0 : 원래색
        // alpha 1 : 투명해짐
        self.blurView.animator.fractionComplete = alpha
    }
}
