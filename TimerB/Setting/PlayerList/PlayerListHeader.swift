//
//  PlayerListHeader.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/20.
//

import UIKit

class PlayerListHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commoninit()
    }

    private func commoninit() {
        let bundle = Bundle(for: PlayerListHeader.self)
         let superView = bundle.loadNibNamed("PlayerListHeader", owner: self, options: nil)?.first as! UIView
         self.addSubview(superView)
         superView.frame = self.bounds
         superView.layoutIfNeeded()
        
     }

}
