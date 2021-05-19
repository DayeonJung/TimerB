//
//  PlayerCell.swift
//  TimerB
//
//  Created by Dayeon Jung on 2021/05/16.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var iconView: RoundedView!
    @IBOutlet weak var playerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.iconView.bgColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
