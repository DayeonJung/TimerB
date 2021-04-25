//
//  SettingView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/25.
//

import UIKit


class SettingView: UIView {

    @IBOutlet weak var blurView: BlurEffectView!
    @IBOutlet weak var noticeContainer: UIView!
    
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
        
        self.noticeContainer.alpha = 0
        
    }
    
    func adjustAlphaOfBlurView(alpha: CGFloat) {
        // alpha 0 : 원래색
        // alpha 1 : 투명해짐
        self.blurView.animator.fractionComplete = alpha
        
        if alpha > 0.5 && self.noticeContainer.alpha == 0 {

            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
                self.noticeContainer.alpha = 1
                self.noticeContainer.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
        }
        
    }
    
    
}
