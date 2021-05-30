//
//  SettingButtonView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

protocol ButtonViewProtocol {
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat)
    func didRecognizeTapGesture()
}

class SettingButtonView: RoundedView {

    var delegate: ButtonViewProtocol?

    var initialFrame: CGRect = .zero
    
    private var intensity: CGFloat {
        let lengthToSlide = self.initialFrame.minX
        let changedX = lengthToSlide - self.frame.minX
        let intensity = min(changedX * 7, lengthToSlide) / lengthToSlide    // 0 < intensity <= 1
        return max(intensity, 0)
    }
    
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
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(self.didTapSettingView)))
        self.initSettingIcon()
        self.initialFrame = self.frame
        
    }

    
    private func initSettingIcon() {
        let settingIconView = UIImageView(image: UIImage(systemName: Icon.GearShape.rawValue))
        settingIconView.tintColor = .white
        settingIconView.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        self.addSubview(settingIconView)
    }
    
    
    @objc private func didPanSettingView(_ sender: UIPanGestureRecognizer) {
        
        let transition = sender.translation(in: self)
        sender.setTranslation(.zero, in: self)

        self.delegate?.didRecognizePanGesture(state: sender.state, intensity: self.intensity)

        
        switch sender.state {
        case .changed:
            self.setCenter(with: transition.x)
            self.setAlpha(with: 1 - self.intensity)
            break
        case .ended:
            let alpha: CGFloat = self.intensity > 0.5 ? 0.0 : 1.0
            self.setUI(with: alpha)

        default:
            break
        }
        
        
    }
    
    
    @objc private func didTapSettingView(_ sender: UITapGestureRecognizer) {

        let alpha: CGFloat = 0.0
        self.setUI(with: alpha)
        
        self.delegate?.didRecognizeTapGesture()

    }
    
    
    private func setUI(with alpha: CGFloat) {
        self.moveTo(frame: self.initialFrame)
        self.setAlpha(with: alpha, animate: true)
    }
    
    
    private func setCenter(with x: CGFloat) {
        let changedX = self.center.x + x
        let maintainingY = self.center.y
        self.center = CGPoint(x: changedX, y: maintainingY)
    }
    
    
    
    private func moveTo(frame: CGRect) {
        self.frame = frame
    }
    
    func setAlpha(with value: CGFloat, animate: Bool = false) {
        
        if animate {
            UIView.animate(withDuration: 0.4) {
                self.alpha = value
            }
        } else {
            self.alpha = value
        }
    }
    
    
    
}
