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

        self.blurView.animator.fractionComplete = alpha
        
        if alpha > 0.5 && self.noticeContainer.alpha == 0 {
            self.animateNoticeContainer(alpha: 1, transform: (1.1, 1.1))
        } else if alpha <= 0.5 {
            self.animateNoticeContainer(alpha: 0, transform: (1.0, 1.0))
        }
        
    }
    
    private func animateNoticeContainer(alpha: CGFloat, transform: (CGFloat, CGFloat)) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
            self.noticeContainer.alpha = alpha
            self.noticeContainer.transform = CGAffineTransform(scaleX: transform.0, y: transform.1)
        }
    }
    
    func setOpenedViewUI() {
        self.blurView.animator.fractionComplete = 1
        self.animateNoticeContainer(alpha: 1, transform: (1.1, 1.1))
    }
    
}
