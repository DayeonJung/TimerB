//
//  SettingTopView.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/04/25.
//

import UIKit

class SettingTopView: RoundedView {
    
    required init(frame: CGRect? = nil,
                  radius: CGFloat? = nil,
                  bgColor: UIColor = .white) {
        
        super.init(frame: frame, radius: radius, bgColor: bgColor)
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
        
        self.initSettingIcon()

        // add a view above all(even navigation bar)
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if keyWindow?.subviews.last?.isKind(of: SettingTopView.self) == false {
            keyWindow?.addSubview(self)
        }
        
    }
    
    private func initSettingIcon() {
        let settingIconView = UIImageView(image: UIImage(systemName: Icon.GearShape.rawValue))
        settingIconView.tintColor = .white
        settingIconView.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        self.addSubview(settingIconView)
    }

    func setCenter(to point: CGPoint) {
        self.center = point
    }
    
}
