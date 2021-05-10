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

    @IBOutlet weak var blurView: BlurEffectView!
    @IBOutlet weak var noticeContainer: UIView!
    
    @IBOutlet var noticeButtons: [IconButton]!
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
        
        self.noticeContainer.alpha = 0
        self.noticeContainer.isHidden = true
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(self.didTapBackground)))
    }
    
    @IBAction func didClickNoticeButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            break
        case 1:
            break
        default:
            break
        }
    }
    
    
    func setButtonsUI(tag: Int, state: Bool) {
        
        self.noticeButtons[tag].set
        
    }
    
    
    
    @objc private func didTapBackground() {
        
        self.delegate?.didRecognizeTapGesture()
        
    }
    
    
    func setBlur(with value: CGFloat) {
        self.blurView.animator.fractionComplete = value
        
        if value > 0.5 && self.noticeContainer.alpha == 0 {
            self.noticeContainer.isHidden = false
            
            self.animateNoticeContainer(alpha: 1, transform: (1.1, 1.1))
            
        } else if value <= 0.5 {
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
