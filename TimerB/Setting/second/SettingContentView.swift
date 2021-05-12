//
//  SettingContentView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

protocol ContentViewProtocol {
    func didRecognizeTapGesture()
}

class SettingContentView: UIView {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var noticeContainer: UIView!
    
    let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut)

    var delegate: ContentViewProtocol?
    
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
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(self.didTapBackground)))
        
        self.blurView.effect = nil
        self.animator.addAnimations { [weak self] in
            self?.blurView.effect = UIBlurEffect(style: .dark)
        }

        self.noticeContainer.alpha = 0
//        self.noticeContainer.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
    }


    
    
    
    @objc private func didTapBackground() {
        
        self.delegate?.didRecognizeTapGesture()
        self.resetUIToInitialState()
        
    }
    
    func resetUIToInitialState() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
            self.alpha = 1
        }
    }
    
    
    func setBlur(with value: CGFloat) {
        
        self.animator.fractionComplete = value

//        if value > 0.5 && self.noticeContainer.alpha == 0 {
//            
//            self.animateNoticeContainer(alpha: 1, transform: (1.0, 1.0))
//            
//        } else if value <= 0.5 {
//            
//            self.animateNoticeContainer(alpha: 0, transform: (0.9, 0.9))
//            
//        }
        
    }
 
    
    private func animateNoticeContainer(alpha: CGFloat, transform: (CGFloat, CGFloat)) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
            self.noticeContainer.alpha = alpha
            self.noticeContainer.transform = CGAffineTransform(scaleX: transform.0, y: transform.1)
        }
    }

//    func setOpenedViewUI() {
//        self.animator.fractionComplete = 1
//        self.animateNoticeContainer(alpha: 1, transform: (1.0, 1.0))
//    }

    
}
