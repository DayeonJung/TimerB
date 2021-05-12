//
//  SettingManager.swift
//  TimerB
//
//  Created by 정다연 on 2021/05/12.
//

import Foundation
import UIKit

class SettingManager {
    
    private let keyWindow: UIWindow? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })

    private var buttonView: SettingButtonView
    private var contentView: SettingContentView
    
    private var fullFrame = CGRect()
    

    
    init() {
        self.buttonView = SettingButtonView(frame: CGRect(x: .mainWidth - 62,
                                                          y: 40,
                                                          width: .mainWidth - 40,
                                                          height: 60),
                                            radius: 30,
                                            bgColor: .systemRed)
        
        self.contentView = SettingContentView(frame: CGRect(origin: .zero,
                                                            size: CGSize(width: .mainWidth,
                                                                         height: .mainHeight)))
        
        self.fullFrame = self.contentView.frame
        
        // add a view above all(even navigation bar)
        if self.keyWindow?.subviews.last?.isKind(of: SettingButtonView.self) == false {
            self.keyWindow?.addSubview(self.buttonView)
            self.buttonView.delegate = self
        }
        
    }
    
}


extension SettingManager: ButtonViewProtocol {
    
    func didRecognizePanGesture(state: UIGestureRecognizer.State, intensity: CGFloat) {
        print(state.rawValue, intensity)
        switch state {
        case .began:
            
            self.keyWindow?.insertSubview(self.contentView, belowSubview: self.buttonView)
            self.contentView.delegate = self
            
            break
            
        case .changed:
            self.contentView.setBlur(with: intensity)
            break
            
        case .ended:
//            if intensity < 0.5 {
//                self.contentView.resetUIToInitialState()
//            }
            break
            
        default:
            break
        }
        
        
    }
    
    
}


extension SettingManager: ContentViewProtocol {
    
    func didRecognizeTapGesture() {
       
        self.buttonView.setAlpha(with: 1, animate: true)
        
    }
    
    
}
