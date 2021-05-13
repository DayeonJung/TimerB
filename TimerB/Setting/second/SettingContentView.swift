//
//  SettingContentView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

protocol ContentViewProtocol {
    func resetUIToInitialState()
}

class SettingContentView: UIView {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var noticeContainer: UIView!
    
    let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut)

    var delegate: ContentViewProtocol?
    
    var noticeContainerIsShowing: Bool = false
    
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
        
        self.animator.pausesOnCompletion = true
        
        self.noticeContainer.alpha = 0

    }


    
    
    
    @objc private func didTapBackground() {
        
        self.delegate?.resetUIToInitialState()
        self.resetUIToInitialState()
        
    }
    
    private func resetUIToInitialState() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 0
        } completion: { _ in
            self.alpha = 1
            self.removeFromSuperview()
            self.animator.fractionComplete = 0
            self.noticeContainer.alpha = 0
        }
    }
    
    
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat) {
        
        switch state {
            
        case .changed:
            self.setBlur(with: intensity)
            break
            
        case .ended:
            if intensity < 0.5 {
                self.resetUIToInitialState()
            } else {
                self.setAnimation(willShow: true)
                self.animator.fractionComplete = 1

            }
            break
            
        default:
            break
        }
        
    }
    
    
    private func setBlur(with value: CGFloat) {

        self.animator.fractionComplete = value
        
        let shouldShow = value > 0.5 && !self.noticeContainerIsShowing
        let shouldHide = value <= 0.5 && self.noticeContainerIsShowing
        
        
        if shouldShow {
            self.setAnimation(willShow: true)
            self.noticeContainerIsShowing = true
        } else if shouldHide {
            self.setAnimation(willShow: false)
            self.noticeContainerIsShowing = false

        }

    }

    
    private func setAnimation(willShow: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut]) {
            self.setNoticeContainerUI(willShow: willShow)
        }
    }
    
    private func setNoticeContainerUI(willShow: Bool) {
        self.noticeContainer.alpha = willShow ? 1 : 0
        let scale: CGFloat = willShow ? 1.1 : 1.0
        self.noticeContainer.transform = CGAffineTransform(scaleX: scale,
                                                           y: scale)
    }
    
}
