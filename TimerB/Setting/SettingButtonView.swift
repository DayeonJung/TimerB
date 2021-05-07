//
//  SettingButtonView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/05.
//

import UIKit

protocol ButtonViewProtocol {
    func didRecognizePanGesture(state: UIGestureRecognizer.State,
                                intensity: CGFloat)
}

class SettingButtonView: RoundedView {

    var delegate: ButtonViewProtocol?
    private var initialFrame: CGRect = .zero
    
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
        
        self.initialFrame = self.frame
        
        
    }

    
    private func initSettingIcon() {
        let settingIconView = UIImageView(image: UIImage(systemName: Icon.GearShape.rawValue))
        settingIconView.tintColor = .white
        settingIconView.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        self.addSubview(settingIconView)
    }
    
    
    @objc func didPanSettingView(_ sender: UIPanGestureRecognizer) {
        
        let transition = sender.translation(in: self)
        let changedX = self.center.x + transition.x
        let maintainingY = self.center.y
        
        self.center = CGPoint(x: changedX, y: maintainingY)
        sender.setTranslation(.zero, in: self)
        
        
        let changedAmount = self.initialFrame.minX - self.frame.minX
        let intensity = min(changedAmount * 10, self.initialFrame.minX) / self.initialFrame.minX    // 0 < intensity <= 1

        
        switch sender.state {
        case .began:

            break
            
        case .changed:

            break
            
        case .ended:
            

            break
            
        default:
            break
        }
        
        self.delegate?.didRecognizePanGesture(state: sender.state,
                                              intensity: intensity)
    }
    
}
