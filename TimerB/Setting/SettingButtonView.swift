//
//  SettingButtonView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

protocol ButtonViewProtocol {
    func didRecognizePanGesture(state: UIGestureRecognizer.State,
                                transitionX: CGFloat)
}

class SettingButtonView: RoundedView {

    var delegate: ButtonViewProtocol?
    
    required init(frame: CGRect? = nil,
                  radius: CGFloat? = nil,
                  bgColor: UIColor = .white) {
        
        super.init(frame: frame,
                   radius: radius,
                   bgColor: bgColor)
        self.commoninit()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }
    
    
    private func commoninit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                                 action: #selector(self.didPanSettingView)))
        self.initSettingIcon()
        
    }

    
    private func initSettingIcon() {
        let settingIconView = UIImageView(image: UIImage(systemName: Icon.GearShape.rawValue))
        settingIconView.tintColor = .white
        settingIconView.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        self.addSubview(settingIconView)
    }
    
    
    @objc func didPanSettingView(_ sender: UIPanGestureRecognizer) {
        
        let transition = sender.translation(in: self)
        sender.setTranslation(.zero, in: self)
        
        self.delegate?.didRecognizePanGesture(state: sender.state,
                                              transitionX: transition.x)
        
    }
    
    
    func setCenter(with x: CGFloat) {
        let changedX = self.center.x + x
        let maintainingY = self.center.y
        self.center = CGPoint(x: changedX, y: maintainingY)
    }
    
    func setAlpha(with value: CGFloat) {
        self.alpha = value
    }
    
}
