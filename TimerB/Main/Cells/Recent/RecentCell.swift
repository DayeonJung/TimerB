//
//  RecentCell.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/09.
//

import UIKit

class RecentCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var timeView: TitleValueView!
    @IBOutlet weak var PlayerView: TitleValueView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.iconView.layer.cornerRadius = self.iconView.bounds.height/2
        self.iconView.clipsToBounds = true
        
    }

    func setUI(with data: RecentOption) {
        self.iconView.backgroundColor = data.color
        self.timeView.setUI(title: "Time", value: String(data.time))
        self.PlayerView.setUI(title: "Player", value: String(data.player))
    }
}
